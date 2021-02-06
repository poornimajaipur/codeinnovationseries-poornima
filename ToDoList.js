import ToDo from "./ToDo";
const TodoList = ({ todos, setTodos, filteredTodos }) => {
  return (
    <div className="todo-container">
      <ul className="todo-list">
        {filteredTodos.map((todo) => (
          <ToDo
            todos={todos}
            setTodos={setTodos}
            text={todo.text}
            todo={todo}
            key={todo.id}
          />
        ))}
      </ul>
    </div>
  );
};

export default TodoList;
