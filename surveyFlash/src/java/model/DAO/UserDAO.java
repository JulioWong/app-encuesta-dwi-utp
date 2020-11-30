package model.DAO;

import config.Database;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Company;
import model.User;
import interfaces.UserInterface;

public class UserDAO implements UserInterface{
    
    Connection DBconnection= new Database().getConnection();
    User user;
    
    @Override
    public User login(String email, String password) {
        User u = new User();        
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spGetLogin(?, ?)}");    
            proc.setString(1, email);
            proc.setString(2, password);
            proc.execute();    
            final ResultSet rs = proc.getResultSet();
            Company company = new Company();

            while (rs.next()) {
                u.setUserid(rs.getInt("userId"));
                u.setFirstName(rs.getString("firstName"));
                u.setLastName(rs.getString("lastName"));
                company.setCompanyId(rs.getInt("companyId"));
                company.setDescription(rs.getString("description"));
                company.setLogo(rs.getString("logo"));
                u.setCompany(company);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        return u;
    }
    
}
