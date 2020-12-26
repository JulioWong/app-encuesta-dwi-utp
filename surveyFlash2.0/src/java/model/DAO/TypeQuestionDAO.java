package model.DAO;

import config.Database;
import interfaces.TypeQuestionInterface;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.TypeQuestion;

public class TypeQuestionDAO implements TypeQuestionInterface{

    Connection DBconnection= new Database().getConnection();
    TypeQuestion typeQuestion;
    
    @Override
    public ArrayList<TypeQuestion> getAll() {
        ArrayList<TypeQuestion> allTypeQuestion = new ArrayList<>();        
        try {
            CallableStatement proc = DBconnection.prepareCall("{CALL spGetTypeQuestions()}");
            proc.execute();    
            final ResultSet rs = proc.getResultSet();  

            while (rs.next()) {  
                typeQuestion = new TypeQuestion();
                typeQuestion.setTypeQuestionId(rs.getInt("typeQuestionId"));
                typeQuestion.setDescription(rs.getString("description"));
                allTypeQuestion.add(typeQuestion);
            }            
        } catch (SQLException ex) {
            Logger.getLogger(TypeQuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        return allTypeQuestion;
    }
    
}
