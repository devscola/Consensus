# Consensus BEM convention for style sheet

## Exemples:

### Naming blocks

* two word: `class="block-name"`
* one word: `class="person"`

### Naming Block parts

* `class="block-name__part"`
* `class="person__hand"`

### Naming Block Modifier 

* `class="block-name--modifier-name"`
* `class="block--modifier"`
* `class="person--female"`

### Naming Block Part Modifier 

* `class="block-name__part-name--modifier-name"`
* `class="block__part--modifier"`
* `class="person__hand--open"`
* `class="person__hair--dark-red"

### Nesting

```html
<div class="block">
    <div class="block__elem1">
        <div class="block__elem2">
            <div class="block__elem3"></div>
        </div>
    </div>
</div>
```

The block structure is always represented as a flat list of elements in the BEM methodology:

```css
.block {}
.block__elem1 {}
.block__elem2 {}
.block__elem3 {}
```

## Rules:

* It's forbiden to create a part inside a block part.
```html

<!-- wrong: -->
class="person__hand__finger"
<!--        -->

<!-- right: -->
class="person__finger"
<!--        -->

```
* A modifier is always a modifier of a block or of a block-part: "In the BEM methodology, a modifier cannot be used outside of the context of its owner."

```html

<!-- wrong: -->
class="block-name modifier-name"
class="person move-forward"
<!--        -->

<!-- right: -->
class="block-name__part-name--modifier-name"
class="person__hand--open"
class="person--walking"
<!--        -->

```
