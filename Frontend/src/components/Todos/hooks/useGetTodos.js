import { useState } from "react";
import { CustomErrorAlert } from "../../../utils/general.js";

const useGetTodos = (setTodos, setNumOfPages) => {
  const [isLoading, setIsLoading] = useState(true);

  const fetchTodos = async (page, limit) => {
    try {
      const response = await fetch(
        `https://fullstack-todolist-upnv.onrender.com/todos?page=${page}&limit=${limit}`
      );
      const data = await response.json();
      setTodos(data.todos);
      setNumOfPages(data.numOfPages);
    } catch (error) {
      CustomErrorAlert(error);
    } finally {
      setIsLoading(false);
    }
  };

  return { fetchTodos, isFetchingTodos: isLoading };
};

export default useGetTodos;
