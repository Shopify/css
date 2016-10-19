# Commenting

## Table of contents
* [Inline comments](#inline-comments)
* [Block comments](#block-comments)
* [Function comments](#function-comments)

## Inline comments
Inline comments should be displayed on the line above the related line of code.

```scss
// Bad!
//
// Comments shouldn't be on the end of a line

.some-thing {
  color: black;
  -webkit-font-smoothing: antialiased; // Needed for clarity
}


// Good!

.some-thing {
  color: black;
  // Needed for clarity
  -webkit-font-smoothing: antialiased;
}
```

## Block comments
Block comments should be used to create meaningful divisions in your file. Each block comment should be preceded by a line with a `//`.

```scss
// Bad!
//
// You shouldn't mix characters for signifying block comments

/*
 This is a bad block comment
*/
.red-bull {
  content: 'bull';
  color: red;
}


// Good!

//
// This is a good block comment
.red-bull {
  content: 'bull';
  color: red;
}
```

## Function comments
Function comments should list the paramers and return values.

```scss
// Bad!
//
// You should list all parameters and the return value

//
// Returns the value in pixels for a given rem value.
@function px($value) {
  @if unit($value) != 'rem' {
    @error 'Value must be in rem.';
  }
  @return ($value / 1rem) * $base-font-size;
}

// Good!

//
// Returns the value in pixels for a given rem value.
// @param {Number} $value - The rem value to be converted.
// @return {Number} The converted value in pixels.

@function px($value) {
  @if unit($value) != 'rem' {
    @error 'Value must be in rem.';
  }
  @return ($value / 1rem) * $base-font-size;
}
```

