# Variables, maps, and functions

## Table of contents
* [Conventions](#conventions)
* [Component specific variables](#component-specific-variables)
* [Available functions](#available-functions)
  * [Spacing](#spacing)
  * [Typography](#typography)
  * [Colors](#colors)

## Conventions
Traditionally in our Sass we would probably set global variables for out base styles in our design system.

This works, but it has some disadvantages. These are global variables that can be mutated at any time and that could change everything that is included after. We don't want this. Instead we use functions to retrieve values from a map.

```scss
// Good!
.body-text {
  color: color(text, primary);
}

// Bad!
.body-text {
  color: #000;
}

.body-text {
  color: $black;
}

.body-text{
  color: map-get($color-palette-data, black);
}
```

By doing it this way we also gain a few benefits. We can:

1. Provide friendlier errors that list available options
1. Use a default value if an option is no longer supported
1. Check for specific types of variables

## Creating new variables for your component
Sometimes you will need to create new variables that will be used in a new component you are building. These variables should be included at the top of the scss file for the component. The variable name should also be prefixed with the name of the component to help keep it name-spaced. An example can be seen in the [example component](../building-a-component/sample-component.scss) included in this repository.

## Available functions

### Spacing

#### spacing(style)
Returns the spacing value for a given variant

`@param {String} $variant The key for the style. Defaults to base.`

`@return {Number} The spacing for the variant`

Example:
```scss
  .some-component {
    padding: spacing();
  }

  .some-other-component {
    padding: spacing(tight);
  }
```

#### Available variants:
- base
- tight
- loose

### Typography

Available styles:
- meta
- emphasized
- body
- section-title
- page-title
- display-title

#### type-size(style)
Returns the font size value for a given typography style

`@param {String} $style The key for the style`

`@return {Number} The font size value`

Example:
```scss
.some-text {
  font-size: type-size(meta);
}
```

#### type-line-height(style)
Returns the line-height value for a given typography style

`@param {String} $style The key for the style`

`@return {Number} The line-height value`

Example:
```scss
.some-text {
  line-height: type-line-height(meta);
}
```

#### type-weight(style)
Returns the font weight value for a given typography style

`@param {String} $style The key for the variant`

`@return {Number} The font-weight value`

Example:
```scss
.some-text {
  line-height: type-line-height(meta);
}
```


### Colors

#### color(group, color)
Returns the color value for a given color name and group

`@param {String} $group The key for the color group`

`@param {String} $color The key for the color name. Defaults to primary.`

`@return {Number} The color value`

Example:
```scss
.some-basic-text {
  color: color(text);
}

.some-error-text {
  color: color(text, error);
}
```

Available groups and colors:
  - text
    - primary
    - secondary
    - hint
    - link
    - error
    - success

Continue on to [Inheriting styles with mixins →](../inheriting-styles-with-mixins)