/* Converted to D from ./jack/jslist.h by htod */
module jack.jslist;
/*
  Based on gslist.c from glib-1.2.9 (LGPL).

  Adaption to JACK, Copyright (C) 2002 Kai Vehmanen.
    - replaced use of gtypes with normal ANSI C types
    - glib's memory allocation routines replaced with
      malloc/free calls

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation; either version 2.1 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

*/

//C     #ifndef __jack_jslist_h__
//C     #define __jack_jslist_h__

//#include <stdlib.h>
//C     #include <stddef.h>
//import std.c.stddef;
//C     #include <jack/systemdeps.h>
import jack.systemdeps;

//C     #ifdef sun
//C     #define __inline__
//C     #endif

//C     typedef struct _JSList JSList;
extern (C):
alias _JSList JSList;

//C     typedef int	(*JCompareFunc)	(void* a, void* b);
alias int  function(void *a, void *b)JCompareFunc;
//C     struct _JSList
//C     {
//C         void *data;
//C         JSList *next;
//C     };
struct _JSList
{
    void *data;
    JSList *next;
}

//C     static //__inline__
//C     JSList*
//C     jack_slist_alloc (void)
//C     {
//C         JSList *new_list;

//C         new_list = (JSList*)malloc(sizeof(JSList));
//C         if (new_list) {
//C             new_list->data = NULL;
//C             new_list->next = NULL;
//C         }

//C         return new_list;
//C     }

//C     static //__inline__
JSList * jack_slist_alloc();
//C     JSList*
//C     jack_slist_prepend (JSList* list, void* data)
//C     {
//C         JSList *new_list;

//C         new_list = (JSList*)malloc(sizeof(JSList));
//C         if (new_list) {
//C             new_list->data = data;
//C             new_list->next = list;
//C         }

//C         return new_list;
//C     }

//C     #define jack_slist_next(slist)	((slist) ? (((JSList *)(slist))->next) : NULL)
//C     static //__inline__
JSList * jack_slist_prepend(JSList *, void *);
//C     JSList*
//C     jack_slist_last (JSList *list)
//C     {
//C         if (list) {
//C             while (list->next)
//C                 list = list->next;
//C         }

//C         return list;
//C     }

//C     static //__inline__
JSList * jack_slist_last(JSList *);
//C     JSList*
//C     jack_slist_remove_link (JSList *list,
//C                             JSList *link)
//C     {
//C         JSList *tmp;
//C         JSList *prev;

//C         prev = NULL;
//C         tmp = list;

//C         while (tmp) {
//C             if (tmp == link) {
//C                 if (prev)
//C                     prev->next = tmp->next;
//C                 if (list == tmp)
//C                     list = list->next;

//C                 tmp->next = NULL;
//C                 break;
//C             }

//C             prev = tmp;
//C             tmp = tmp->next;
//C         }

//C         return list;
//C     }

//C     static //__inline__
JSList * jack_slist_remove_link(JSList *, JSList *);
//C     void
//C     jack_slist_free (JSList *list)
//C     {
//C         while (list) {
//C             JSList *next = list->next;
//C             free(list);
//C             list = next;
//C         }
//C     }

//C     static //__inline__
void  jack_slist_free(JSList *);
//C     void
//C     jack_slist_free_1 (JSList *list)
//C     {
//C         if (list) {
//C             free(list);
//C         }
//C     }

//C     static //__inline__
void  jack_slist_free_1(JSList *);
//C     JSList*
//C     jack_slist_remove (JSList *list,
//C                        void *data)
//C     {
//C         JSList *tmp;
//C         JSList *prev;

//C         prev = NULL;
//C         tmp = list;

//C         while (tmp) {
//C             if (tmp->data == data) {
//C                 if (prev)
//C                     prev->next = tmp->next;
//C                 if (list == tmp)
//C                     list = list->next;

//C                 tmp->next = NULL;
//C                 jack_slist_free (tmp);

//C                 break;
//C             }

//C             prev = tmp;
//C             tmp = tmp->next;
//C         }

//C         return list;
//C     }

//C     static //__inline__
JSList * jack_slist_remove(JSList *, void *);
//C     unsigned int
//C     jack_slist_length (JSList *list)
//C     {
//C         unsigned int length;

//C         length = 0;
//C         while (list) {
//C             length++;
//C             list = list->next;
//C         }

//C         return length;
//C     }

//C     static //__inline__
uint  jack_slist_length(JSList *);
//C     JSList*
//C     jack_slist_find (JSList *list,
//C                      void *data)
//C     {
//C         while (list) {
//C             if (list->data == data)
//C                 break;
//C             list = list->next;
//C         }

//C         return list;
//C     }

//C     static //__inline__
JSList * jack_slist_find(JSList *, void *);
//C     JSList*
//C     jack_slist_copy (JSList *list)
//C     {
//C         JSList *new_list = NULL;

//C         if (list) {
//C             JSList *last;

//C             new_list = jack_slist_alloc ();
//C             new_list->data = list->data;
//C             last = new_list;
//C             list = list->next;
//C             while (list) {
//C                 last->next = jack_slist_alloc ();
//C                 last = last->next;
//C                 last->data = list->data;
//C                 list = list->next;
//C             }
//C         }

//C         return new_list;
//C     }

//C     static //__inline__
JSList * jack_slist_copy(JSList *);
//C     JSList*
//C     jack_slist_append (JSList *list,
//C                        void *data)
//C     {
//C         JSList *new_list;
//C         JSList *last;

//C         new_list = jack_slist_alloc ();
//C         new_list->data = data;

//C         if (list) {
//C             last = jack_slist_last (list);
//C             last->next = new_list;

//C             return list;
//C         } else
//C             return new_list;
//C     }

//C     static //__inline__
JSList * jack_slist_append(JSList *, void *);
//C     JSList*
//C     jack_slist_sort_merge (JSList *l1,
//C                            JSList *l2,
//C                            JCompareFunc compare_func)
//C     {
//C         JSList list, *l;

//C         l = &list;

//C         while (l1 && l2) {
//C             if (compare_func(l1->data, l2->data) < 0) {
//C                 l = l->next = l1;
//C                 l1 = l1->next;
//C             } else {
//C                 l = l->next = l2;
//C                 l2 = l2->next;
//C             }
//C         }
//C         l->next = l1 ? l1 : l2;

//C         return list.next;
//C     }

//C     static //__inline__
JSList * jack_slist_sort_merge(JSList *, JSList *, JCompareFunc );
//C     JSList*
//C     jack_slist_sort (JSList *list,
//C                      JCompareFunc compare_func)
//C     {
//C         JSList *l1, *l2;

//C         if (!list)
//C             return NULL;
//C         if (!list->next)
//C             return list;

//C         l1 = list;
//C         l2 = list->next;

//C         while ((l2 = l2->next) != NULL) {
//C             if ((l2 = l2->next) == NULL)
//C                 break;
//C             l1 = l1->next;
//C         }
//C         l2 = l1->next;
//C         l1->next = NULL;

//C         return jack_slist_sort_merge (jack_slist_sort (list, compare_func),
//C                                       jack_slist_sort (l2, compare_func),
//C                                       compare_func);
//C     }

//C     #endif /* __jack_jslist_h__ */

