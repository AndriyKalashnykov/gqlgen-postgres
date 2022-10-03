package graph

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.

import (
	"context"
	"fmt"
	"log"

	"github.com/AndriyKalashnykov/gqlgen-postgres/graph/generated"
	"github.com/AndriyKalashnykov/gqlgen-postgres/graph/model"
	"github.com/AndriyKalashnykov/gqlgen-postgres/internal/pkg/todo"
	"github.com/google/uuid"
)

// CreateTodo is the resolver for the createTodo field.
func (r *myMutationResolver) CreateTodo(ctx context.Context, todo model.TodoInput) (*model.Todo, error) {
	id, err := r.ToDo.Create(todo.Text, *todo.Done)
	if err != nil {
		return nil, err
	} else {
		log.Printf("To Do saved with identifier: %s", *id)
		return &model.Todo{
			ID:   *id,
			Text: todo.Text,
			Done: *todo.Done,
		}, nil
	}
}

// UpdateTodo is the resolver for the updateTodo field.
func (r *myMutationResolver) UpdateTodo(ctx context.Context, id string, updatedTodo model.TodoInput) (*model.Todo, error) {
	_, err := uuid.Parse(id)
	if err != nil {
		return nil, fmt.Errorf("invalid identifier: %s", id)
	}
	err = r.ToDo.Update(id, updatedTodo.Text, *updatedTodo.Done)
	if err != nil {
		return nil, err
	} else {
		log.Printf("To Do with identifier: %s updated", id)
		return &model.Todo{
			ID:   id,
			Text: updatedTodo.Text,
			Done: *updatedTodo.Done,
		}, nil
	}
}

// Todo is the resolver for the todo field.
func (r *myQueryResolver) Todo(ctx context.Context, id string) (*model.Todo, error) {
	_, err := uuid.Parse(id)
	if err != nil {
		return nil, fmt.Errorf("invalid identifier: %s", id)
	}
	item, err := r.ToDo.Get(id)
	if err != nil {
		return nil, err
	} else {
		return &model.Todo{
			ID:   item.Id,
			Text: item.Text,
			Done: item.IsDone,
		}, nil
	}
}

// Todos is the resolver for the todos field.
func (r *myQueryResolver) Todos(ctx context.Context) ([]*model.Todo, error) {
	var items []*model.Todo
	var savedItems []todo.ToDoItem
	savedItems, err := r.ToDo.List()
	if err != nil {
		return nil, err
	}
	for i, savedItem := range savedItems {
		var item model.Todo
		savedItem = savedItems[i]
		item.ID = savedItem.Id
		item.Text = savedItem.Text
		item.Done = savedItem.IsDone
		items = append(items, &item)
	}
	return items, nil
}

// MyMutation returns generated.MyMutationResolver implementation.
func (r *Resolver) MyMutation() generated.MyMutationResolver { return &myMutationResolver{r} }

// MyQuery returns generated.MyQueryResolver implementation.
func (r *Resolver) MyQuery() generated.MyQueryResolver { return &myQueryResolver{r} }

type myMutationResolver struct{ *Resolver }
type myQueryResolver struct{ *Resolver }
