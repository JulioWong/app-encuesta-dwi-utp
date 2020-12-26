package interfaces;

import java.util.ArrayList;
import model.Company;
import model.Survey;

public interface SurveyInterface {
    public Survey get(int surveyId);
    public ArrayList<Survey> getAll(Company company);
    public boolean add(int userId, Survey survey, Company company);
    public boolean update(Survey survey);
    public boolean active(int surveyId, int companyid, int active);
}
