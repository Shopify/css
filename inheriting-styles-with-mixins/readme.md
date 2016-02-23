# Inheriting styles with mixins

## Table of contents
* [Why mixins?](#why-mixins)
* [Creating a new mixin for your component](#creating-a-new-mixin-for-your-component)
* [Available mixins](#available-functions)
  * [Spacing](#spacing)
  * [Typography](#typography)

## Why mixins?
Mixins provide a handy way for a new component to inherit styles from the design system. For example, rather than applying multiple properties and values in our SCSS, we can simply include a mixin like `@include body-text`.

```scss
// Good!
.component__title {
  @include section-title;
}

// Bad!
.component__title {
  font-size: type-size(section-title);
  line-height: type-line-height(section-title);
  font-weight: type-weight(section-title);
  color: color(text, primary);
}
```

This allows us to keep components consistent with the design system, because they can inherit all the styles needed.


## Creating a new mixin for your component
Sometimes you will want to create new mixins to be used in a new component you are building. These mixins should be included at the top of the scss file for the component. The mixin name should also be prefixed with the name of the component to help keep it name-spaced. An example can be seen in the [example component](../building-a-component/sample-component.scss) included in this repository.

## Available mixins

There are several mixins already available to be used in your own components.

### Spacing

#### vertical-rhythm(variant)

`@param {String} $group The spacing variant to apply between children`

This mixin will add even spacing between all the direct children of the container it is applied to. It allows you to pass the spacing variant you want to be applied between the children.

Example:
```scss
.card__section {
  @include vertical-rhythm;
}

.card__section--compact {
  @include vertical-rhythm(tight);
}
```

### Typography

#### section-title

Example:
```scss
.card__title {
  @include section-title;
}
```

#### page-title

Example:
```scss
.header__title {
  @include page-title;
}
```

#### display-title

Example:
```scss
.empty-state__title {
  @include page-title;
}
```

#### body-text

Example:
```scss
.banner__content {
  @include body-text;
}
```

#### meta-text

Example:
```scss
.section__description {
  @include meta-text;
}
```

#### emphasized-text

Example:
```scss
.card__callout {
  @include emphasized-text;
}
```
