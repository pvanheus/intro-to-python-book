This repository has content for the SANBI Introduction to Python course, 2026 edition.

To run a live webserver:

```bash
pixi run jupyter book  start --execute
```

To build HTML pages:

```bash
pixi run jupyter book build --execute --html --strict 
```

And then upload to the web root of jupyterhub.sanbi.ac.za with:

```bash
rsync -rP _build/html/ ubuntu@jupyterhub.sanbi.ac.za:/var/www/html
```

To generate a PDF of the content:
```bash
pixi run jupyter book build --execute --pdf
```
A downloadable PDF is automatically generated when the site is built and included as a downloadable option.