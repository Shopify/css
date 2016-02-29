# Using common styles with mixins

## Table of contents
* [Why mixins?](#why-mixins)
* [Creating a new mixin for your component](#creating-a-new-mixin-for-your-component)

## Why mixins?
Mixins provide a way for a component to compose itself using a set of common styles from the design system. For example, rather than applying multiple properties and values in our SCSS, we can simply include a mixin like `@include body-text`.

```scss
// Bad!
.component__title {
  font-size: type-size(section-title);
  line-height: type-line-height(section-title);
  font-weight: type-weight(section-title);
  color: color(text, primary);
}

// Good!
.component__title {
  @include section-title;
}
```

This allows us to keep components consistent with the design system, because they can inherit all the styles needed.


## Creating a new mixin for your component
Sometimes you will want to create new mixins to be used in a new component you are building. These mixins should be included at the top of the Sass file for the component. The mixin name should also be prefixed with the name of the component to help keep it name-spaced. An example can be seen in the [example component](../building-a-component/sample-component.scss) included in this repository.
