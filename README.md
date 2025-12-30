[![Tests](https://github.com/koendehondt/hera-for-pharo/actions/workflows/main.yml/badge.svg)](https://github.com/koendehondt/hera-for-pharo/actions/workflows/main.yml) [![codecov](https://codecov.io/gh/koendehondt/hera-for-pharo/graph/badge.svg?token=TJ1JGZUBTM)](https://codecov.io/gh/koendehondt/hera-for-pharo)

# Hera for Pharo

Hera is a BDD framework for [Pharo](https://www.pharo.org), based on [Gherkin](https://cucumber.io/docs/gherkin/) and inspired by [Cucumber](https://cucumber.io) and [Spinach](https://github.com/codegram/spinach).

To load it:

```smalltalk
Metacello new
   baseline: 'Hera';
   repository: 'github://koendehondt/hera-for-pharo:main';
	onConflict: [ :e | e useIncoming ];
	onUpgrade: [ :e | e useIncoming ];
	ignoreImage;
   load
```

**Beware:** Hera is under continuous development, so it changes a lot.

You can open a feature browser from the `Browse` menu in the Pharo menu bar.

You can also do it by hand. Open a Feature Browser on your own acceptance tests (so without all the features used for testing Hera):
```smalltalk
    HeraApplication new openFeatureBrowser
```

Open a Feature Browser with all features in the image:
```smalltalk
    HeraApplication new openFeatureBrowserOnAll
```
## Blog

Read the [introduction](https://all-objects-all-the-time.st/#/blog/posts/13).

## Documentation

Read the [documentation](https://all-objects-all-the-time.st/#/projects/hera).

## Contributions

If you would like to contribute, please fork the repo and submit a pull request.

Please run the unit tests before submitting a pull request. You can use Dr Test to run them all after filtering the package list on "Hera".

A pull request will be rejected without further comment if the unit tests are not green or the test coverage decreases.
