package model.DAO;

import config.Database;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Company;
import interfaces.CompanyInterface;

public class CompanyDAO implements CompanyInterface{
    
    Connection DBconnection= new Database().getConnection();
    Company company;

    @Override
    public ArrayList<Company> getAll() {
        ArrayList<Company> allCompany = new ArrayList<>();        
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spGetCompanies()}");    
            proc.execute();    
            final ResultSet rs = proc.getResultSet();  

            while (rs.next()) {  
                company = new Company();
                company.setCompanyId(rs.getInt("companyId"));
                company.setDescription(rs.getString("description"));
                company.setLogo(rs.getString("logo"));
                allCompany.add(company); 
            }            
        } catch (SQLException ex) {
            Logger.getLogger(CompanyDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        return allCompany;
    }
    
}
