package com.ezen.ezenhr.service;

import com.ezen.ezenhr.domain.UserVo;

import java.util.List;

public class UserUpdateForm {

    private List<UserVo> userList;

    public List<UserVo> getUserList() {
        return userList;
    }

    public void setUserList(List<UserVo> userList) {
        this.userList = userList;
    }
}