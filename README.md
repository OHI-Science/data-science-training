## Collaborative. Reproducible. Science.

  These materials are available as a book at http://ohi-science.org/data-science-training/. (Alternative [link](https://rawgit.com/OHI-Science/data-science-training/master/docs/index.html).

Please clone or download https://github.com/OHI-Science/data-science-training to accompany this training.

### Rendering

To render this book in RStudio: Build tab > Build Book. Or on the command line:

```R
rmarkdown::render_site(encoding = 'UTF-8')
````

This will build the HTML and PDF versions of the book into the `docs/` folder, which should not be directly edited (and occassionally completely deleted before rendering to remove old unused files).

### Acknowledgements

Many thanks to the creators of `bookdown`: 

- Yihui Xie (2016). bookdown: Authoring Books and Technical Documents with R Markdown. R package version 0.3.9.
- Yihui Xie (2016). bookdown: Authoring Books and Technical Documents with R Markdown. Chapman and Hall/CRC. ISBN 978-1138700109
