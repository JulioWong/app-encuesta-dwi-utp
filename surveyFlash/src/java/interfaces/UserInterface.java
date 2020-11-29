package interfaces;

import model.User;

public interface UserInterface {
    public User login(String email, String password);
}
