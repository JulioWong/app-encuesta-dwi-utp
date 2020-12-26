package model.DAO;

import config.Database;
import interfaces.AlternativeInterface;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Alternative;

public class AlternativeDAO implements AlternativeInterface{
    
    Connection DBconnection= new Database().getConnection();
    Alternative alternative;
    
    @Override
    public ArrayList<Alternative> get(int questionId) {
        ArrayList<Alternative> allAlternative = new ArrayList<>();        
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spGetAlternativesByQuestion(?)}");  
            proc.setInt(1, questionId);
            proc.execute();    
            final ResultSet rs = proc.getResultSet();
            
            Alternative alter;

            while (rs.next()) {
                alter = new Alternative();
                alter.setAlternativeId(rs.getInt("alternativeId"));
                alter.setDescription(rs.getString("description"));
                allAlternative.add(alter); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(SurveyDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        return allAlternative;
    }

    @Override
    public ArrayList<Alternative> getAll(int questionId) {
        ArrayList<Alternative> allAlternative = new ArrayList<>();        
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spGetAlternatives(?)}");
            proc.setInt(1, questionId);
            proc.execute();    
            final ResultSet rs = proc.getResultSet();  

            while (rs.next()) {  
                alternative = new Alternative();
                alternative.setAlternativeId(rs.getInt("alternativeId"));
                alternative.setQuestionId(rs.getInt("questionId"));
                alternative.setDescription(rs.getString("description"));
                allAlternative.add(alternative); 
            }            
        } catch (SQLException ex) {
            Logger.getLogger(CompanyDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        return allAlternative;
    }

    @Override
    public boolean add(Alternative alternative) {
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spInsAlternative(?, ?)}");
            proc.setInt(1, alternative.getQuestionId());
            proc.setString(2, alternative.getDescription());
            proc.execute();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public boolean delete(int alternativeId) {
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spDelAlternative(?)}");
            proc.setInt(1, alternativeId);
            proc.execute();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    } 
    
}
