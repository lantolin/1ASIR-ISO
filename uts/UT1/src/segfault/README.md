# Sistemas operativos y protección de memoria

Este programa demuestra que una cosa es la gestión de memoria que hace el programador y otra la protección de memoria del SO

Este programa reserva solo 100 bytes, pero luego se pone a escribir empezando en esos 100 bytes pero sigue hasta el infinito.

El SO no le mata en el 101, porque en realidad le ha asignado varias páginas de RAM, de modo que son realmente suyas. Escribir en tu RAM puede ser un error de programación (y lo es), pero no es una violación a nivel de SO porque el SO te asigna RAM en páginas (de hecho de varias en varias como se puede ver).

En un Linux debian 13 sobre Intel fallaba en :

134496 |fish: Job 1, './segfault1' terminated by signal SIGSEGV (Address boundary error)
