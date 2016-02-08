# Markup and Styling Style Guide

This is a detailed style guide for building and reviewing UI components at Shopify, with a focus on HTML and CSS (as well as Sass).  For any feedback or discussion, please email **front-end-developers@shopify.com** or visit the **#fed** Slack. This style guide is a living document that we both expect **and** hope will change as we learn from our mistakes, so don’t be shy!

### Table of contents
* [Before you start](#before-you-start)
* [Code style](#code-style)
* [HTML](#html)
* [CSS](#css)
  * [CSS naming conventions](#naming-conventions)
  * [Sass](#sass)
    * [Sass syntax, comments, and linting](#syntax-and-spacing)
* [Images](#images)
* [Related style guides](#related-style-guides)
* [Contributing](#contributing)

## Before you start:
Shopify has two strong design systems: [**the admin system**](http://styleguide.myshopify.com/) and [**the marketing system**](http://ux.shopify.io). Within these, UI patterns should be documented and built to be re-useable as often as possible. Refer to the [admin style guide](http://styleguide.myshopify.com/) and [marketing style guide](http://ux.shopify.io) for examples of existing patterns.

* New patterns and variations will be introduced over time, and these should be introduced back to the style guides immediately, or built in a way where they can be incorporated later with minimal refactoring.
* To achieve this, it’s preferred to use classes free of context and avoiding context-dependent selectors, particularly for brand new components. Examples: `.carousel` instead of `.home-carousel`, `.my-very-special-new-module` instead of `.some-context > .my-very-special-new-module`.

Before you begin building, start with the “why?”.

* Brand new UI patterns should be solving particular UX issues.
* You should consider the effects on shipping fast and maintainability.
* All new patterns we introduce to users are new patterns that users will have to learn.

Leave a code base in a better state than when you started. Refactor as you go.

Don’t knowingly create technical debt. Don’t add “TODO” or “I’ll fix this later” comments. If something needs to be addressed in a future PR, a GitHub issue should be opened immediately.

Code should be self documenting but, where it cannot be, decisions and logic should be documented (e.g. magic numbers, responding to a browser bug, etc.).

## Code style
* Use **spaces** indented by 2.
* Whitespace is removed, except for a new line at the end of a file.
* Keep line lengths below 80 characters for improved readability on github.
* Suggested Sublime settings [Preferences.sublime-settings](https://github.com/Shopify/fed-sandbox/blob/master/code/project-dots/Preferences.sublime-settings).

## HTML
* Write [valid HTML5](https://html5.validator.nu/).
* Write semantically correct, accessible HTML.
* IDs use **UpperCamelCase**, e.g. `<div id="LegalContent"></div>`.
* For styling purposes, IDs should be avoided. Styling should be done via CSS classes.
* JavaScript relies on classes and IDs as needed, with classes used in repeated components.

## CSS
* CSS is written with [CSM](building-a-component) principles, so that most components are either Blocks, Elements, or Modifiers.
* Structure modules so that they are reusable. If you’re defining the same attributes multiple times to the same effect, they should probably be refactored into a single reusable module. Note that this rule may not make sense for layout styles.
* Structure modules so they build off each other. Instead of monolith components, favor smaller units that can be stitched together to build new patterns.
* Modules should follow the [Single Responsibility Principle](http://cssguidelin.es/#the-single-responsibility-principle)
* To maximize re-usability, modifiers are favored over context-specific styles. Modules should be [open for extension; closed for modification.](http://cssguidelin.es/#further-reading-7).
* Module styles should not be overwritten without a modifier or variation:

  BAD:

  ```scss
  .heading-4 {
    font-size: 25px;
  }

  .somecontext .heading-4 {
    font-size: 25px;
  }
  ```

  GOOD:

  ```scss
  .heading-4 {
    font-size: 25px;
  }

  .new-heading-class {
    font-size: 25px;
  }

  /* or */
  .heading-4--description {
    font-size: 25px;
  }
  ```
* Specificity breeds specificity. Use the simplest selector possible and avoid nesting. This simplifies overrides and creating modifiers. [http://css-tricks.com/specifics-on-css-specificity/](http://css-tricks.com/specifics-on-css-specificity/)
* Avoid “Magic Numbers” and document why they’re there if you must. [http://css-tricks.com/magic-numbers-in-css/](http://css-tricks.com/magic-numbers-in-css/). For example:
  ```scss
  .my-class {
    margin-right: -207px; // adjusting for exact size of some picture
  }
  ```
* Be consistent with units. If using `px` for layout, consistently use `px`.
* If you’re having to undo the styles on a module for an exception, chances are your module was doing too much. This is a [code smell](http://en.wikipedia.org/wiki/Code_smell) and you should consider refactoring.
* If you run into a CSS problem, take code away before you start adding more in a bid to fix it. The problem will exist in the CSS that is already written and more CSS isn’t necessarily the right answer! ([Read this helpful article about debugging CSS](http://tech.tmw.co.uk/code/TMW-frontend-guidelines/#section-css-debugging)).

### Naming conventions
* Name your classes, mixins, and variables so that other developers can read and use them (e.g. no `.rb125`). Naming conventions should clarify intent.
* CSS classes are defined using lower-case-with-dashes, e.g. `.page-header`.
* Keep class names devoid of context. `.carousel` instead of `.homepage-carousel`, `.filters` instead of `.special-page-filters`. [courtesy of Brad Frost](https://twitter.com/brad_frost/status/545233202445828096)
* Use [BEM naming syntax](http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/).
  * Use `--` for module specific variations (see [BEM](http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/)).
    * e.g. `.module--blue-border` would extend or overwrite the styles of `.module`
  * For child elements of components with specific styles, use `__`.
    * e.g. `.special-container` has a special heading style with class `.special-container__heading`
* In the BEM method, combining too many children with variants can get messy and can be a sign that things need to be rethought.
 * You shouldn’t need classes like this: `.section--main__header__description__link`.
* Classes prepended with `is-` should be used for active, disabled, and other states. These are usually set by JavaScript (e.g. `.is-loading`).
* Use `.js-` for JavaScript handles that do not affect stylesheets.

### Sass
* CSS is written using Sass in the `.scss` syntax.
* Sass allows for deep nesting, but nesting more than 2 levels deep is highly discouraged because it creates a high level of specificity.
* Global `@mixin`, `@function`, and `$variables` should be defined within a top level file (name of file might vary depending on project or design system, e.g. 'mixins.scss', 'variables.scss', 'dependencies.scss', etc.). Component-specific mixins and vars can be added to module-level mixin files.
  * For example, variables related only to typography, like `font-family`, would be placed in `_typography.scss`.
* Use `@extend` sparingly, and never across modules. `@extend` can lead to some [scary selectors](http://www.sitepoint.com/sass-extend-nobody-told-you/), and worse, unintended dependencies across non-related modules.
  * If you can’t abstract into a shared class, it probably doesn’t make sense to `@extend` either.
  * `mixins` are a good alternative to sharing styles across unrelated components. These keep your CSS DRY from a dev perspective, while not creating dependencies where there should be none.
* Variables and mixins should be named using lower-case-with-dashes, e.g. `$like-this`.

#### Syntax and Spacing

Refer to the [Sass lint config](https://github.com/Shopify/markup-and-styling-style-guide/blob/master/.scss-lint.yml) file for rules on spacing and syntax. Read on for some additional things not covered in the config file.

* Use shorthand syntax for selectors when appropriate.

  ```scss
  .selector {
    padding: 10px 20px;
  }
  ```

* Only use shorthands when necessary. For example to change the right and left padding only:

  ```scss
  .selector {
    padding-left: 10px;
    padding-right: 10px;
  }
  ```

* Do not use the nested shorthand syntax.

  BAD:

  ```scss
  .selector {
    padding: {
      left: 10px;
      right: 10px;
    }
  }
  ```

  GOOD:

  ```scss
  .selector {
    padding-left: 10px;
    padding-right: 10px;
  }
  ```

* Use `::` for pseudo elements and `:` for pseudo classes. [It is the right thing to do](http://www.w3.org/TR/css3-selectors/#pseudo-elements).

  ```scss
  .selector::before {
    ...
  }

  .selector:hover {
    ...
  }
  ```

#### Commenting
Major CSS sections should be commented with the following:

     /*============================================================================
       Main Nav
         * extra detail here as needed
     ==============================================================================*/

Subsections should be commented with the following

    /*================ Responsive  ================*/


Where annotations or explanations are needed (magic numbers, browser quirks, etc.), they should happen inline.

```scss
.my-class {
  margin-right: -207px; // adjusting for exact size of some picture
}
```

#### Linting
[Sass Lint](https://github.com/causes/scss-lint) automates much of the above. Agreed on settings can be found in this repo `.scss-lint.yml`. If you wish to change them, feel free to open a pull request.

It is highly recommended that you set up your text editor to automatically run linters.

Refer to individual projects or design systems documentation for how to run the linters.

## Images
* Links to any resources from CSS should use link-helpers (e.g. Rails asset pipeline, Liquid asset helper).
* Icons are usually implemented as [SVGs](https://css-tricks.com/svg-sprites-use-better-icon-fonts/), either inline HTML or as CSS background images.
* `srcset` and `sizes` are used for responsive content images.
  * [Picturefill JS](https://github.com/scottjehl/picturefill) is a polyfill that supports this technique in older browsers.
  * [Marketing Assets responsive images module](http://ux.shopify.io/styleguide/modules/responsive_image).
  * [Marketing Assets picture module](http://ux.shopify.io/styleguide/modules/picture).
* Images should use appropriate naming conventions to indicate their sizes.
  * Retina images should use the `-2x` convention, e.g. `someimage-2x.jpg`.
  * Following the picture strategy, you indicate the targeted device and whether the image targets retina, e.g. `@mobile`, `@mobile-2x`, `@tablet`, `@tablet-2x`, `@desktop`, `@desktop-2x`.
  * Following the srcset strategy, you may use `-small`, `-medium`, `-large`, `-full` though there is no strict convention.
* All images include a helpful `alt` attribute. [Read this article about crafting a good alt attribute](http://www.w3.org/WAI/tutorials/images/decision-tree/).
  * An exception is images that are purely decorative and have no bearing on the content (e.g. a background image that you are animating). These types of images should have an empty `alt` attribute `alt=""` so that the HTML is valid.

## Related Style Guides

Here are links to our Style Guides for other Front End languages.

### “Vanilla JavaScript”
[JavaScript Style Guide](https://github.com/Shopify/eslint-config-shopify)

### CoffeeScript
[CoffeeScript Style Guide](https://github.com/Shopify/CoffeeScript-Style-Guide)

### EcmaScript 20xx and JSX
[eslint-config-shopify](https://github.com/Shopify/eslint-config-shopify)

## Contributing

Pull Requests are welcome if you want to challenge existing conventions or add new ones. Please follow the usual workflow and ping **@Shopify/fed** on the Pull Request.
