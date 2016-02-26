# Variables, maps, and functions

## Table of contents
* [Conventions](#conventions)
* [Component specific variables](#component-specific-variables)

## Conventions
Rather than using global variables, we prefer to use functions to retrieve values from a map. By doing it this way we it allows us to:

1. Provide friendlier errors that list available options
1. Use a default value if an option is no longer supported
1. Validate the data type of a retrieved value
1. Loop over values in a map to generate new styles

```scss
// Bad!
//
// You should never refer to hex values directly in your component
.body-text {
  color: #000;
}

// Bad!
//
// You should never refer to global variables directly
.body-text {
  color: $black;
}

// Bad!
//
// You should never fetch values from a map directly, use a function instead
.body-text{
  color: map-get($color-palette-data, black);
}

// Good!
.body-text {
  color: color(text, primary);
}
```

## Creating new variables for your component
Sometimes you will need to create new variables that will be used in a new component you are building. These variables should be included at the top of the SCSS file for the component. The variable name should also be prefixed with the name of the component to help keep it name-spaced. An example can be seen in the [example component](../building-a-component/sample-component.scss) included in this repository.

Continue on to [Inheriting styles with mixins →](../inheriting-styles-with-mixins)
