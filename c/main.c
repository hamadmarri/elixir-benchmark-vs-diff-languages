#include "stdio.h"
#include "stdlib.h"
#include <time.h>

const int entropy = 10;
const int max_digit = entropy;
#define solution_size 9

struct stack_int
{
    int value;
    struct stack_int *next;
    int count;
    int ref_num;
};

struct stack_stack
{
    struct stack_int *value;
    struct stack_stack *next;
};

void push_stack_int(struct stack_int **s, int v)
{
    struct stack_int *new_n = (struct stack_int *)malloc(sizeof(struct stack_int));

    new_n->value = v;
    new_n->ref_num = 0;
    new_n->next = *s;
    *s = new_n;
    (*s)->count = 1;

    if ((*s)->next)
    {
        (*s)->next->ref_num++;
        (*s)->count = (*s)->next->count + 1;
    }
}

struct stack_int *pop_stack_int(struct stack_int **s)
{
    struct stack_int *h = *s;
    *s = (*s)->next;
    (*s)->count--;
    (*s)->ref_num--;

    return h;
}

void print_stack_int(struct stack_int *s)
{
    struct stack_int *n = s;
    printf("[ ");
    while (n)
    {
        // printf("%d -> %p ", n->value, n->next);
        printf("%d ", n->value);
        n = n->next;
    }
    // printf("]s:%d ", s->count);
    printf("] ");
}

void push_stack_stack(struct stack_stack **s, struct stack_int *v)
{
    struct stack_stack *new_n = (struct stack_stack *)malloc(sizeof(struct stack_stack));

    new_n->value = v;
    new_n->next = *s;
    *s = new_n;
}

struct stack_stack *pop_stack_stack(struct stack_stack **s)
{
    struct stack_stack *h = *s;
    *s = (*s)->next;
    return h;
}

void print_stack_stack(struct stack_stack *s)
{
    struct stack_stack *n = s;
    printf("[ ");
    while (n)
    {
        print_stack_int(n->value);
        n = n->next;
    }
    printf("]\n");
}

struct stack_stack *initCh(int *stat)
{
    int i;
    struct stack_stack *ss = NULL;

    for (i = 1; i <= entropy; i++)
    {
        struct stack_int *s = NULL;
        push_stack_int(&s, i);
        push_stack_stack(&ss, s);
    }

    *stat = entropy;
    return ss;
}

void distroy_stack_ints(struct stack_int *item)
{
    struct stack_int *h;

    while (item && item->ref_num == 0)
    {
        // printf("FREE S_INT ");
        // print_stack_int(item);
        h = item->next;
        free(item);
        // printf(" ;\n");
        item = h;
        if (item)
        {
            item->ref_num--;
            // printf("ref_num: %d\n", item->ref_num);
        }
    }
}

void distroy_stacks(struct stack_stack *ss)
{
    struct stack_stack *itr_ss = ss;
    struct stack_int *itr_s = NULL;
    struct stack_stack *s;
    struct stack_int *n;

    // printf("call distroy_stacks\n");

    while (itr_ss)
    {
        // printf("inter s: \n");
        s = itr_ss;
        itr_s = itr_ss->value;
        itr_ss = itr_ss->next;
        // printf("free s: \n");
        // print_stack_int(itr_s);
        // printf("\n");
        free(s);
        // printf(" ok \n");

        distroy_stack_ints(itr_s);
        // printf("out n\n");
    }
}

int is_solution(struct stack_int *item, int *solution)
{
    int i;

    if (item->count != solution_size)
        return 0;

    for (i = 0; i < solution_size; i++)
    {
        if (!item)
            return 0;

        if (item->value != solution[i])
            return 0;

        item = item->next;
    }

    return 1;
}

void genCh(struct stack_stack **ss, struct stack_int *parent_items, int *stat)
{
    if (parent_items->count >= max_digit)
    {
        // printf("max digit\n");
        return;
    }

    for (int i = 1; i <= entropy; i++)
    {
        // deep copy
        struct stack_int *ch = parent_items;
        push_stack_int(&ch, i);
        push_stack_stack(ss, ch);
    }

    *stat = *stat + entropy;
}

void solve(struct stack_stack *ss, int *solution, int *stat)
{
    struct stack_stack *item_ss;
    struct stack_int *item;

    while (1)
    {
        // printf("SOLVE: ");
        // print_stack_stack(ss);

        if (ss == NULL)
        {
            printf("Q IS EMPTY!, QUITTING!, count: %d\n", *stat);
            return;
        }

        // pop
        item_ss = pop_stack_stack(&ss);
        item = item_ss->value;
        // printf("FREE SS ");
        // print_stack_int(item_ss->value);
        free(item_ss);
        // printf("\n");

        // printf("ITEM: ");
        // print_stack_int(item);
        // printf("\n");

        // check
        if (is_solution(item, solution))
        {
            printf("FOUND A SOLUTION: ");
            print_stack_int(item);
            printf("count: %d\n", *stat);
            distroy_stack_ints(item);
            printf("done distroy stack ints\n");
            distroy_stacks(ss);
            printf("done distroy stack stacks\n");
            return;
        }

        // gen
        genCh(&ss, item, stat);
        distroy_stack_ints(item);
    }
}

int main()
{
    int i;

    for (i = 0; i < 10; i++)
    {
        struct timespec start, end;

        clock_gettime(CLOCK_MONOTONIC, &start);
        int stat = 0;
        struct stack_stack *ss = initCh(&stat);
        int solution[solution_size] = {7, 7, 7, 7, 7, 7, 7, 5, 10};
        // int solution[solution_size] = {2, 1, 3};

        print_stack_stack(ss);

        solve(ss, solution, &stat);

        clock_gettime(CLOCK_MONOTONIC, &end);

        long long duration = (end.tv_sec - start.tv_sec) * 1000000LL + (end.tv_nsec - start.tv_nsec) / 1000LL;
        double df = duration / 1000.0f;
        df /= 1000.0f;

        printf("time: %lfs\n", df);
    }
    return 0;
}
