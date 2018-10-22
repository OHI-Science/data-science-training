## Collaborative. Reproducible. Science.

These materials are available as a book at http://ohi-science.org/data-science-training. (Alternative [link](https://rawgit.com/OHI-Science/data-science-training/master/docs/index.html)).

Please clone or download https://github.com/OHI-Science/data-science-training to accompany this training.
<br>
<br>
<br>

### Rendering

To render this book in RStudio: Build tab > Build Book. Or on the command line:

```R
rmarkdown::render_site(encoding = 'UTF-8')
````

This will build the HTML and PDF versions of the book into the `docs/` folder, which should not be directly edited (and occassionally completely deleted before rendering to remove old unused files).

### Teaching Setup

This book as been used for Software Carpentry workshops and the OHI Fellows program (recordings on the [OHI-Science YouTube Channel](https://www.youtube.com/watch?v=xpe7jmt0-J4&list=PLX7J3qtjcll_4s2oaKHuWdRdBMJz7tBAU)).

Prior to teaching:

- github chapter: since `my-repo` has been created, consider `[placename]-repo` e.g. `whoi-repo`
- before ggplot2 chapter: `install.packages('tidyverse')`


### Acknowledgements

Many thanks to the creators of `bookdown`: 

- Yihui Xie (2016). bookdown: Authoring Books and Technical Documents with R Markdown. R package version 0.3.9.
- Yihui Xie (2016). bookdown: Authoring Books and Technical Documents with R Markdown. Chapman and Hall/CRC. ISBN 978-1138700109
