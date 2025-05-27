# Difference between Criminal Activity, Allegation, and Disturbing

These types of problematic content capture similar scenarios:

- `criminal_activity`
- `allegation`
- `disturbing`

They do have differences between them.

## Criminal Activity

The `criminal_activity` type detects actual ongoing activity. For example: Attempts to sell illicit items online, death threats, and more. 

The purpose of this type is to detect foul play going in the content. Nothing else.

It is not the same as *conversations* about alleged criminal acts. For example, if an article describes a sting raid on a meth lab, it is not tagged as abuse. 

If you are looking to locate conversations about crimes, look at the `topics` section.

Also see: [Criminal Activity](./criminalactivity.md)

## Allegation

What happens if someone talks about a crime that allegedly happened to them? This is what `allegation` is meant to tackle. 

The difference between `allegation` and `criminal_activity` is similar to the venerable [*This is not a pipe*](https://en.wikipedia.org/wiki/The_Treachery_of_Images) by René Magritte.

We don’t know if it’s true and it’s not happening right now, but we should not ignore it. 

On the other hand, we can’t lump it together with the *criminal activity* type, because it would create false positives in communities of survivors of abuse, for example. 

For law enforcement needs, the distinction must be clear, too: an allegation is not the same as actual activity. And even if it’s a real crime is to be reported, the procedures are very different.

Also see: [Allegations](./allegation.md)

## Disturbing

The third type, `disturbing`, flags graphic depictions of death, injury, etc. whether they are crime-related, or not. 

In most cases, these depictions do not overlap with the `criminal_activity` type. 

They may or may not overlap with the `allegation` type. 

Not all death or injury are considered disturbing, too.

Also see: [Disturbing Content](./disturbing.md)
