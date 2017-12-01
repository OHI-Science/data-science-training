# libraries ----
library(tidyverse)

# data ----
url <- 'https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/gapminder.csv'
gapminder <- read_csv(url) # View(gapminder)

# ggplot: after filter by country ----
gapminder %>%
  filter(country == "Afghanistan") %>%
  ggplot(aes(x = year, y = gdpPercap)) +
  geom_point() +
  geom_smooth() +
  labs(title = "Afghanistan")

# ggsave: after filter by country & plot ----
png <- "gdp_Afghanistan.png"

g <- gapminder %>%
  filter(country == "Afghanistan") %>%
  ggplot(aes(x = year, y = gdpPercap)) +
  geom_point() +
  geom_smooth() +
  labs(title = "Afghanistan")

ggsave(filename = png, plot = g)

# function: for plotting any country ----
plot_country <- function(cntry){

  png <- paste0("gdp_", cntry, ".png")

  g <- gapminder %>%
    filter(country == cntry) %>%
    ggplot(aes(x = year, y = gdpPercap)) +
    geom_point() +
    geom_smooth() +
    labs(title = cntry)

  ggsave(filename = png, plot = g)
}

plot_country("Afghanistan")

# for: loop to iterate over some countries ----
countries <- c("United States", "Mexico")

for (k in countries){

  plot_country(k)

}

# debug: inside function and for loop ----
plot_country <- function(cntry){

  png <- paste0("gdp_", cntry, ".png")

  #browser()
  cat("plot_country(", cntry,") -> ", png, "\n")

  g <- gapminder %>%
    filter(country == cntry) %>%
    ggplot(aes(x = year, y = gdpPercap)) +
    geom_point() +
    geom_smooth() +
    labs(title = cntry)

  ggsave(filename = png, plot = g)
}

countries <- c("Fiji", "Peru", "Mexico")

for (k in countries){

  #browser()
  cat("for () { k: ", k," }\n")

  plot_country(k)
}

# if: output to different folder based on gdp ----
dir.create("developed")
dir.create("developing")

plot_country <- function(cntry, png){

  cat("plot_country(", cntry,", ", png, ")\n")

  g <- gapminder %>%
    filter(country == cntry) %>%
    ggplot(aes(x = year, y = gdpPercap)) +
    geom_point() +
    geom_smooth() +
    labs(title = cntry)

  ggsave(filename = png, plot = g)
}

is_developed <- function(cntry, threshold = 12000){
  #browser() # cntry <- "Canada"
  gapminder %>%
    filter(country == cntry) %>%
    summarise(
      mean_gdp = mean(gdpPercap)) %>%
    .$mean_gdp >= threshold
}

countries <- c("United States", "Canada", "Afghanistan", "Rwanda")

for (k in countries){

  if (is_developed(k)){
    png <- paste0("developed/gdp_", k, ".png")
  } else {
    png <- paste0("developing/gdp_", k, ".png")
  }

  plot_country(k, png)
}
