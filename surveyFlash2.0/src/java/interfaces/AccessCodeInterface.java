package interfaces;

import java.util.ArrayList;
import model.AccessCode;

public interface AccessCodeInterface {
    public ArrayList<AccessCode> getAll(int surveyId);
    public boolean add(AccessCode accessCode);
    public boolean delete(int accessCodeId);
    public AccessCode verify(String accessCode);
}
