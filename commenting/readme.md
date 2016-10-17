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
Block comments should have a line with a `//` before and after the comment.

```scss
// Bad!
//
// You shouldn't mix characters for signifying block comments

/*
 This is a Sass block comment
*/
.red-bull {
  content: 'bull';
  color: red;
}


// Good!

//
// This is a Sass block comment
//
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
// Returns the string passed in.
//
@function yoyo($string) {
  @return $string;
}

// Good!

//
// Returns the string passed in.
//
// @param {String} $string - A string value.
// @return {String} Your string.
//
@function yoyo($string) {
  @return $string;
}
```

