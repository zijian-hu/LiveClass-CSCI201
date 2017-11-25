package database.object;

public class User {
    private int userID;
    private String username;
    private String password;
    private String firstName;
    private String lastName;
    private String email;
    private String salt;

    public User() {
        //
    }

//    public User(String username, String password) {
//        this.username = username;
//        this.password = password;
//    }
    
    public User(String username, String password, String fname, String lname, String email, String salt) {
		super();
//		this.userID = userID;
		this.username = username;
		this.password = password;
		this.firstName = fname;
		this.lastName = lname;
		this.email = email;
		this.salt = salt;
	}

	public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String fname) {
		this.firstName = fname;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lname) {
		this.lastName = lname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}
    
}
