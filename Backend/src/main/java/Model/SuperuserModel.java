package Model;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class SuperuserModel {
    public Boolean LoginSuperUser(String username, String password) {
        // Check she/he login as a Teacher of Admin
        String file_path;
        file_path = "data/super_user.txt";
        // now Check DataBase for existing user in database or no - if yes will return True
        try (BufferedReader reader = new BufferedReader(new FileReader(file_path))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().indexOf('*') == 0) continue;
                String[] user_detail = line.split(",");
                if (username.equalsIgnoreCase(user_detail[0]) &&
                        password.equalsIgnoreCase(user_detail[1])) {
                    return true;
                }
            }

            return false;
        } catch (IOException e) {
            System.out.println("Error!!");
            e.printStackTrace();
            return false;
        }
    }


}
