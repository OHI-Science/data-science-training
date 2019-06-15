# dataprep for ggplot2


library(dplyr)
library(here)

OHI_score <- read.csv("https://raw.githubusercontent.com/OHI-Science/ohi-global/draft/yearly_results/global2017/Results/data/scores_eez2017.csv") %>%
  select(rgn_id = region_id, region_name, OHI_score=Index) %>%
  filter(rgn_id != 0)

OHI_trend <- read.csv("https://raw.githubusercontent.com/OHI-Science/ohi-global/draft/yearly_results/global2017/Results/data/trends_2017.csv") %>%
  select(rgn_id = region_id, OHI_trend=Index) %>%
  filter(rgn_id != 0)

hdi <- read.csv("https://raw.githubusercontent.com/OHI-Science/ohiprep/master/globalprep/supplementary_information/v2017/HDI_data.csv") %>%
  select(rgn_id, HDI=X2015)

# coastal population
pop <- read.csv("https://raw.githubusercontent.com/OHI-Science/ohiprep/master/globalprep/mar_prs_population/v2017/output/mar_pop_25mi.csv") %>%
  filter(year == 2017) %>%
  select(rgn_id, coastal_pop = popsum) %>%
  mutate(log_coastal_pop = log(coastal_pop + 1))

## chi data
chi <- read.csv("https://raw.githubusercontent.com/OHI-Science/ohiprep/master/globalprep/supplementary_information/v2016/CHI_data.csv") %>%
  filter(sp_type == "eez") %>%
  select(rgn_id, cumulative_human_impact=mean)

## UN georegion
georegion <- read.csv("https://raw.githubusercontent.com/OHI-Science/ohiprep/master/globalprep/spatial/v2017/output/georegion_labels.csv") %>%
  select(rgn_id, georegion_one = r1_label, georegion_two = r2_label)

data <- OHI_score %>%
  left_join(OHI_trend, by="rgn_id") %>%
  left_join(pop, by="rgn_id") %>%
  left_join(chi, by="rgn_id") %>%
  left_join(hdi, by="rgn_id") %>%
  left_join(georegion, by="rgn_id") %>%
  select(-rgn_id, country=region_name)

write.csv(data, "data/OHI_global_data.csv", row.names=FALSE)


## OHI score summary

ohi_data <- read_csv(here("data/OHI_global_data.csv"))

ohi_summary <- ohi_data %>%
  group_by(georegion_one) %>%
  summarize(OHI_score = mean(OHI_score))

write_csv(ohi_summary, here("data/OHI_scores_georegion_summary.csv"))
