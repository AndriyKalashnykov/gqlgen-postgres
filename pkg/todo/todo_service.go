package todo

import "time"

type ToDoItem struct {
	Id        string
	Text      string
	IsDone    bool
	CreatedOn time.Time
	UpdatedOn *time.Time
}

type ToDo interface {
	Initialise() error
	Create(text string, isDone bool) (*string, error)
	Update(id string, text string, isDone bool) error
	Get(id string) (*ToDoItem, error)
	List() ([]ToDoItem, error)
}
