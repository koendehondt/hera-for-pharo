# Hera for Pharo

Hera is a BDD framework for [Pharo](https://www.pharo.org), based on [Gherkin](https://cucumber.io/docs/gherkin/) and inspired by [Cucumber](https://cucumber.io) and [Spinach](https://github.com/codegram/spinach).

To load it:

```smalltalk
Metacello new
   baseline: 'Hera';
   repository: 'github://koendehondt/hera-for-pharo:main';
   load
```

**Beware:** Hera is under continuous development, so it changes a lot.

Open a Feature Browser with all features in the image:
```smalltalk
(HeraFeatureBrowser new analytics: HeraAnalytics all) open
```

Open a Feature Browser without all the features used for testing Hera:
```smalltalk
HeraFeatureBrowser new open
```

Open a Step Browser to see all the steps in the image:
```smalltalk
HeraStepBrowser new open
```
