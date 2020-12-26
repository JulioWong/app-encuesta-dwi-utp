package model.DAO;

import config.Database;
import interfaces.AccessCodeInterface;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.AccessCode;

public class AccessCodeDAO implements AccessCodeInterface{
    
    Connection DBconnection= new Database().getConnection();
    AccessCode accessCode;

    @Override
    public ArrayList<AccessCode> getAll(int surveyId) {
        ArrayList<AccessCode> allAccessCode = new ArrayList<>();        
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spGetAccessCode(?)}");  
            proc.setInt(1, surveyId);
            proc.execute();    
            final ResultSet rs = proc.getResultSet();  

            while (rs.next()) {  
                accessCode = new AccessCode();
                accessCode.setAccessCodeId(rs.getInt("accessCodeId"));
                accessCode.setDocument(rs.getString("code"));
                accessCode.setFirstName(rs.getString("firstName"));
                accessCode.setLastName(rs.getString("lastName"));
                accessCode.setEmail(rs.getString("email"));
                accessCode.setCellPhone(rs.getString("cellPhone"));
                allAccessCode.add(accessCode);
            }            
        } catch (SQLException ex) {
            Logger.getLogger(SurveyDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        return allAccessCode;
    }

    @Override
    public boolean add(AccessCode accessCode) {
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spInsAccessCode(?, ?, ?, ?, ?, ?)}");  
            proc.setInt(1, accessCode.getSurveyId());
            proc.setString(2, accessCode.getDocument());
            proc.setString(3, accessCode.getFirstName());
            proc.setString(4, accessCode.getLastName());
            proc.setString(5, accessCode.getEmail());
            proc.setString(6, accessCode.getCellPhone());
            proc.execute();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(SurveyDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public boolean delete(int accessCodeId) {
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spDelAccessCode(?)}");
            proc.setInt(1, accessCodeId);
            proc.execute();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public AccessCode verify(String accessCode) {
        AccessCode access = new AccessCode();        
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spVerififyAccessCode(?)}");  
            proc.setString(1, accessCode);
            proc.execute();    
            final ResultSet rs = proc.getResultSet();  

            while (rs.next()) {
                access.setAccessCodeId(rs.getInt("accessCodeId"));
                access.setSurveyId(rs.getInt("surveyId"));
                access.setFirstName(rs.getString("firstName"));
                access.setLastName(rs.getString("lastName"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SurveyDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        return access;
    }
}
