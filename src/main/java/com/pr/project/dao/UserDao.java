package com.pr.project.dao;

import com.pr.project.model.User;

public interface UserDao {

	User select(String user_id);

	User select1(String user_nickname);

	int insert(User user);

}
