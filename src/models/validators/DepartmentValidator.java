package models.validators;

import java.util.ArrayList;
import java.util.List;

import models.Department;

public class DepartmentValidator {
    public static List<String> validate(Department d){
        List <String> errors = new ArrayList<String>();

        String name_error = _validateName(d.getName());
        if(!name_error.equals("")) {
            errors.add(name_error);
        }
        return errors;

    }

    private static String _validateName(String name) {
        if(name == null || name.equals("")){
            return "部署名を入力してください。";
        }

        return "";
    }
}