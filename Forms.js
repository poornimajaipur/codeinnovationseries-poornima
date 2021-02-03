import App from "./App.css";

const Forms = ({ inputText, setInputText, todos, setTodos, setStatus }) => {
  const inputTextHandler = (e) => {
    setInputText(e.target.value);
  };

  const submitToDoHandler = (e) => {
    e.preventDefault();
    setTodos([
      ...todos,
      {
        text: inputText,
        completed: false,
        id: Math.random() * 1000,
      },
    ]);
    setInputText("");
  };

  const statusHandler = (e) => {
    setStatus(e.target.value);
  };

  return (
    <div>
      <form className="inputForm">
        <input
          value={inputText}
          onChange={inputTextHandler}
          type="text"
          className="inputBar"
        />
        <button
          onClick={submitToDoHandler}
          className="inputButton"
          type="submit"
        >
          <i className="fas fa-plus-square"></i>
          Add
        </button>
        <div className="select">
          <select onChange={statusHandler} name="todos" className="filter-todo">
            <option value="all">All</option>
            <option value="completed">Completed</option>
            <option value="active">Active</option>
          </select>
        </div>
      </form>
    </div>
  );
};

export default Forms;
