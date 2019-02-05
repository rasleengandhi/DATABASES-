# DATABASES-
/*
CSCI2141 Winter 2018 - Project
This is the front-end application for users to interact with the movie rental system
 */

package Haliflix;

import java.sql.*;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.TextField;
import javafx.scene.control.Label;
import javafx.scene.control.RadioButton;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.media.Media;
import javafx.scene.media.MediaPlayer;
import javafx.scene.media.MediaView;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.stage.Stage;

public class HaliFlix extends Application
{
    //Mysql connection vars
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost/HALIFLIX";
    static final String USER = "root"; //root
    static final String PASS = "xxxxxx"; // write the password you created for sql connection 
    
    
    //to get input search
    private String input;
    
    
    //scenes
    Scene scene1, scene2, scene3;
    
   //labels 1
   private Label plaintext = new Label("     ");
   private Label enctext = new Label("     ");
   private Label key = new Label("     ");
   private Label exchange = new Label("     ");
   private Label show = new Label("Show: "); 
   private Label by = new Label(" by: ");
   private Label results = new Label("Results"); 
   private Button exit1 = new Button("Exit");
   
   
   
   //labels 2 
   private Label title = new Label("Title: "); 
   private Label genre = new Label("Genre: "); 
   private Label director = new Label("Director: "); 
   private Label price = new Label("Price: "); 
   private Label avail = new Label("Availability: "); 
   private Label rest = new Label("Restriction: ");
   private Button back1 = new Button("Back");
   private Button rent = new Button("Rent");
   private Button exit2 = new Button("Exit");
   private Button trailer = new Button("Watch Trailer");
   
   //labels 3
   private Label custID = new Label("Customer ID: ");
   private Label custPass = new Label("Password: ");
   private Label rentD = new Label("Days to rent: ");
   private Label priceT = new Label("Total Cost: $0.00");
   private Button login = new Button("Login");
   private Label loginM = new Label("Sucessfully logged in"); //change to: Incorrect id or password, if wrong
   private Button back2 = new Button("Back");
   private Button purchase = new Button("Purchase"); //Only if they were able to log in
   private boolean logged = false; //Track if logged in
   private Button exit3 = new Button("Exit");
   private Button estimate = new Button("Calculate Cost");
   private TextField inCustID;
   private TextField inCustPass;
   private ComboBox<Integer> cbDays = new ComboBox<Integer>();
   private DecimalFormat df2 = new DecimalFormat("####0.00");
   private Label purchaseM = new Label("Sucessfully purchased");

   
   
   
       private String mgenre="";
       private int mdirID=0;
       private int mid=0;
       private int mrest=0;
       private String mdir="";
       private String mprice="";
       private int mavail=0;
       private String mtrailer="";
       
       private String cusid="";
       private String cuspass="";
       private int daysRent = 0;
       private double cost=0.0;
       
   
   //radio buttons
   private RadioButton genrebutton = new RadioButton("Genre");
   private RadioButton titlebutton = new RadioButton("Title");
   private RadioButton directorbutton = new RadioButton("Director");
   private RadioButton allbutton = new RadioButton("All");
   private RadioButton availablebutton = new RadioButton("Available");
   
   //text fields
   private TextField inputsearch;
   
   //buttons
   private Button reset = new Button("Reset");
   private Button search = new Button("Search");
   private Button showAll = new Button("All Available Movies");
   private Button more = new Button("More info");
   
   
   //ArrayList of labels for the movie o=to choose
   private ArrayList<String> moviesNames = new ArrayList<String>();
   private ComboBox<String> cb = new ComboBox<String>();
   private int found=0;
   private String selectedMovie;
   
    private Stage primaryStage;

   //pane
   GridPane pane1 = new GridPane();
   GridPane pane2 = new GridPane();
   GridPane pane3 = new GridPane();
   
   //font for all labels
   Font font1 = Font.font("Arial", FontWeight.BOLD, 14);
   Font font2 = Font.font("Arial", FontWeight.BOLD, 18);
   
   //variable, searchbykey, to keep track of which attribute is being searched by
   private int searchbyKey = 0;
   
   //variable, showKey, to keep track of whether we are searching all movies or only those that are available
   private int showKey = 0;
   
   @Override
   public void start(Stage primaryStage)
   {
       this.primaryStage = primaryStage;
      //naming labels
      Label searchLabel = new Label("Search:");
      
      //setting text fields and their sizes
      inputsearch = new TextField();
      inputsearch.setPrefWidth(300);
      
      //setting fonts for labels
      show.setFont(font1);
      by.setFont(font1);
      searchLabel.setFont(font1);
      results.setFont(font2);
      
      //detecting events for text fields, reset button and radio buttons
      reset.setOnAction(this::processReset);
      genrebutton.setOnAction(this::processRadioButtonAction);
      titlebutton.setOnAction(this::processRadioButtonAction);
      directorbutton.setOnAction(this::processRadioButtonAction);
      allbutton.setOnAction(this::processRadioButtonAction);
      availablebutton.setOnAction(this::processRadioButtonAction);
      search.setOnAction(this::processSearch);
      showAll.setOnAction(this::processShowAll);
      more.setOnAction(this::processMore);
      exit1.setOnAction(this::processExit);
      
      
      
      //pane2
      title.setFont(font2);
      genre.setFont(font2);
      director.setFont(font2);
      price.setFont(font2);
      avail.setFont(font2);
      rest.setFont(font2);
      back1.setOnAction(this::processBack);
      rent.setOnAction(this::processRent);
      exit2.setOnAction(this::processExit);

      
      //selecting default search criteria
      allbutton.setSelected(true);
      genrebutton.setSelected(true);
      
      //adding nodes and styles to pane1
      pane1.setPadding(new Insets(20, 20, 20, 20));
      pane1.setHgap(20);
      pane1.setVgap(10);
      pane1.setStyle("-fx-background-color:CADETBLUE");
      pane1.add(searchLabel, 0, 0); //
      pane1.add(inputsearch, 1, 0);
      pane1.add(by, 2, 0);
      pane1.add(genrebutton, 3, 0);
      pane1.add(titlebutton, 4, 0);
      pane1.add(directorbutton, 5, 0);
      pane1.add(search, 0, 8);
      pane1.add(reset, 1, 8);
      pane1.add(exit1, 2, 8);
      pane1.add(showAll, 0, 10);
      pane1.add(show, 0, 2);
      pane1.add(allbutton, 1, 2);
      pane1.add(availablebutton, 1, 3);
      pane1.add(results, 0, 12);
      results.setVisible(false);
      pane1.add(more,1,13);
      pane1.add(cb,0,13);
      cb.setVisible(false);
      more.setVisible(false);
      
      
      
      
      //adding nodes and styles to pane2
      pane2.setPadding(new Insets(20, 20, 20, 20));
      pane2.setHgap(20);
      pane2.setVgap(10);
      pane2.setStyle("-fx-background-color:CADETBLUE");
      pane2.add(title,0,0);
      pane2.add(genre,0,1);
      pane2.add(director,0,2);
      pane2.add(rest,0,3);
      pane2.add(avail,0,4);
      pane2.add(price,0,6);
      pane2.add(back1,0,7);
      pane2.add(rent,1,7);
      pane2.add(exit2,3,7);
      pane2.add(trailer,0,5);
      trailer.setOnAction(this::processTrailer);
      
      //adding nodes and styles to pane3
      custID.setFont(font2);
      custPass.setFont(font2);
      loginM.setFont(font1);
      rentD.setFont(font2);
      priceT.setFont(font2);
      rentD.setFont(font2);
      pane3.setPadding(new Insets(20, 20, 20, 20));
      pane3.setHgap(20);
      pane3.setVgap(10);
      pane3.setStyle("-fx-background-color:CADETBLUE");
      pane3.add(custID,0,0);
      pane3.add(custPass,0,1);
      pane3.add(login,1,3);
      pane3.add(loginM,1,2);
      loginM.setVisible(false); //Don't show yet
      pane3.add(rentD,0,4); //ComboBox 1-15
      pane3.add(priceT,0,5);
      pane3.add(back2,0,7);
      pane3.add(purchase,1,7);
      pane3.add(exit3,2,7);
      pane3.add(estimate,2,4);
      back2.setOnAction(this::processBack);
      estimate.setOnAction(this::processEstimate);
      exit3.setOnAction(this::processExit);
      purchase.setOnAction(this::processPurchase);
      login.setOnAction(this::processLogin);
      purchase.setDisable(true);//Enable if logged in
      inCustID = new TextField();
      inCustID.setPrefWidth(200);
      inCustPass = new TextField();
      inCustPass.setPrefWidth(200);
      pane3.add(inCustID,1,0);
      pane3.add(inCustPass,1,1);
      cbDays.getItems().addAll(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);
      pane3.add(cbDays,1,4);
      purchaseM.setFont(font1);
      pane3.add(purchaseM,0,8);
      purchaseM.setVisible(false);

      
      //creating a scene with the pane
      scene1 = new Scene(pane1, 1000, 500);
      scene2 = new Scene(pane2, 1000, 500);
      scene3 = new Scene(pane3, 1000, 500);
      
      //creating a stage with the scene and displaying the stage
      primaryStage.setTitle("HaliFlix Rental Tool");
      primaryStage.setScene(scene1);
      primaryStage.show();
   }
   
   //event handler for radio buttons
   public void processRadioButtonAction (ActionEvent event)
   {
      if (event.getSource() == genrebutton) //if the genre button is pressed
      {
         titlebutton.setSelected(false); //title and director buttons are unselected
         directorbutton.setSelected(false);
         searchbyKey = 0; //searchbyKey is set to 0 (search by genre)
      }
      if (event.getSource() == titlebutton) //if the title button is pressed
      {
         genrebutton.setSelected(false); //genre and director buttons are unselected
         directorbutton.setSelected(false);
         searchbyKey = 1; //searchbyKey is set to 1 (search by title)
      }
      if (event.getSource() == directorbutton) //if director button is pressed
      {
         genrebutton.setSelected(false); //genre and title buttons are unselected
         titlebutton.setSelected(false);
         searchbyKey = 2; //searchbyKey is set to 2 (search by director)
      }
      if(event.getSource() == allbutton) //if all button is pressed
      {
         availablebutton.setSelected(false); //available button is unselected
         showKey = 0; //showKey is set to 0 (show all movies matching search criteria)
      }
      if(event.getSource() == availablebutton) //if available button is pressed
      {
         allbutton.setSelected(false); //all button is unselected
         showKey = 1; //showKey is set to 1 (show all available movies matcing search criteria)
      }
       
   }
      
   //event handler for reset button
   public void processReset (ActionEvent event)
   {
      //clear text fields
       primaryStage.setScene(scene1);
      inputsearch.clear();
      purchaseM.setVisible(false);

      
      //unselect radio buttons 
      genrebutton.setSelected(true);
      titlebutton.setSelected(false);
      directorbutton.setSelected(false);
      availablebutton.setSelected(false);
      allbutton.setSelected(true);
      
      //set searchbyKey and showKey to 0 (default search is all by genre)
      searchbyKey = 0;
      showKey = 0;
      
      results.setVisible(false);
      cb.setVisible(false);
      more.setVisible(false);
      //ClEAR COMBOBOX
      cb.getItems().clear();
   }
   
   public void processSearch(ActionEvent event)
   {
       //Every new search reset
       moviesNames.clear();
       cb.getItems().clear();
       
      //Get input if not empty
      if (inputsearch.getText() != null && !inputsearch.getText().isEmpty())
      {
        results.setVisible(true);
        input = inputsearch.getText();

        //Execute queries depending on this
        if (searchbyKey == 1 && showKey == 0) //by title, show all
        {
          try 
          {
              Connection conn = null;
              Statement stmt = null;
              Class.forName(JDBC_DRIVER);
              System.out.println("Connecting to database...");
              conn = DriverManager.getConnection(DB_URL,USER,PASS);
              System.out.println("Creating statement...");
              stmt = conn.createStatement();
              String sql = "SELECT MOV_NAME FROM MOVIE WHERE MOV_NAME='" + input + "' ORDER BY MOV_NAME ASC";
              ResultSet rs = stmt.executeQuery(sql);
  
              moviesNames.clear(); //Clear arraylist
              
              while(rs.next()) 
              {
                  String mname = rs.getString("MOV_NAME");
                  System.out.println(mname);
                  found = 1;
                  //Add result to arraylist
                  moviesNames.add(mname);
              }

              rs.close();
              stmt.close();
              conn.close();
          }//End try

          catch(SQLException se){}
          catch(Exception e){System.out.println("Done");}
        }


        else if (searchbyKey == 1 && showKey == 1) //by title, show available
        {
          try 
          {
              Connection conn = null;
              Statement stmt = null;
              Class.forName(JDBC_DRIVER);
              System.out.println("Connecting to database...");
              conn = DriverManager.getConnection(DB_URL,USER,PASS);
              System.out.println("Creating statement...");
              stmt = conn.createStatement();
              String sql = "SELECT MOV_NAME FROM MOVIE WHERE MOV_NAME='" + input + "' AND MOV_ID NOT IN (SELECT MOV_ID FROM MOVIE_RENTAL WHERE RETURNED=0) ORDER BY MOV_NAME ASC";
              ResultSet rs = stmt.executeQuery(sql);
              moviesNames.clear();
              
              while(rs.next()) 
              {
                  String mname = rs.getString("MOV_NAME");
                  System.out.println(mname);
                  found = 1;
                  //Add result to arraylist
                  moviesNames.add(mname);
              }

              
              rs.close();
              stmt.close();
              conn.close();
          }//End try

          catch(SQLException se){}
          catch(Exception e){System.out.println("Done");}
        }

        else if (searchbyKey == 0 && showKey == 0) //by genre, show all
        {
          try 
          {
              Connection conn = null;
              Statement stmt = null;
              Class.forName(JDBC_DRIVER);
              System.out.println("Connecting to database...");
              conn = DriverManager.getConnection(DB_URL,USER,PASS);
              System.out.println("Creating statement...");
              stmt = conn.createStatement();
              String sql = "SELECT MOV_NAME FROM MOVIE WHERE MOV_GENRE='" + input + "' ORDER BY MOV_NAME ASC";
              ResultSet rs = stmt.executeQuery(sql);
              //Clear arraylist
              moviesNames.clear();
              
              while(rs.next()) 
              {
                  String mname = rs.getString("MOV_NAME");
                  System.out.println(mname);
                  found = 1;
                  //Add result to arraylist
                  moviesNames.add(mname);
              }
              

              
              rs.close();
              stmt.close();
              conn.close();
          }//End try

          catch(SQLException se){}
          catch(Exception e){System.out.println("Done");}
        }

        else if (searchbyKey == 0 && showKey == 1) //by genre, show available
        {
          try 
          {
              Connection conn = null;
              Statement stmt = null;
              Class.forName(JDBC_DRIVER);
              System.out.println("Connecting to database...");
              conn = DriverManager.getConnection(DB_URL,USER,PASS);
              System.out.println("Creating statement...");
              stmt = conn.createStatement();
              String sql = "SELECT MOV_NAME FROM MOVIE WHERE MOV_GENRE='" + input + "' AND MOV_ID NOT IN (SELECT MOV_ID FROM MOVIE_RENTAL WHERE RETURNED=0) ORDER BY MOV_NAME ASC";
              ResultSet rs = stmt.executeQuery(sql);
              moviesNames.clear();
              
              while(rs.next()) 
              {
                  String mname = rs.getString("MOV_NAME");
                  System.out.println(mname);
                  found = 1;
                  //Add result to arraylist
                  moviesNames.add(mname);
              }
              

              
              rs.close();
              stmt.close();
              conn.close();
          }//End try

          catch(SQLException se){}
          catch(Exception e){System.out.println("Done");}
        }
        
        else if (searchbyKey == 2 && showKey == 0) //by director, show all
        {
          try 
          {
              Connection conn = null;
              Statement stmt = null;
              Class.forName(JDBC_DRIVER);
              System.out.println("Connecting to database...");
              conn = DriverManager.getConnection(DB_URL,USER,PASS);
              System.out.println("Creating statement...");
              stmt = conn.createStatement();
              String sql = "SELECT MOV_NAME FROM MOVIE WHERE DIR_ID IN (SELECT DIR_ID FROM DIRECTOR WHERE CONCAT(DIR_F_NAME, ' ', DIR_L_NAME)='" + input + "' OR DIR_F_NAME='" + input + "' OR DIR_L_NAME='" + input + "') ORDER BY MOV_NAME ASC";
              ResultSet rs = stmt.executeQuery(sql);
              moviesNames.clear();
              
              while(rs.next()) 
              {
                  String mname = rs.getString("MOV_NAME");
                  System.out.println(mname);
                  found = 1;
                  //Add result to arraylist
                  moviesNames.add(mname);
              }
              

              
              rs.close();
              stmt.close();
              conn.close();
          }//End try

          catch(SQLException se){}
          catch(Exception e){System.out.println("Done");}
        }
        
        else if (searchbyKey == 2 && showKey == 1) //by director, show available
        {
          try 
          {
              Connection conn = null;
              Statement stmt = null;
              Class.forName(JDBC_DRIVER);
              System.out.println("Connecting to database...");
              conn = DriverManager.getConnection(DB_URL,USER,PASS);
              System.out.println("Creating statement...");
              stmt = conn.createStatement();
              String sql = "SELECT MOV_NAME FROM MOVIE WHERE DIR_ID IN (SELECT DIR_ID FROM DIRECTOR WHERE CONCAT(DIR_F_NAME, ' ', DIR_L_NAME)='" + input + "' OR DIR_F_NAME='" + input + "' OR DIR_L_NAME='" + input + "') AND MOV_ID NOT IN (SELECT MOV_ID FROM MOVIE_RENTAL WHERE RETURNED=0) ORDER BY MOV_NAME ASC";
              ResultSet rs = stmt.executeQuery(sql);
              moviesNames.clear();
              
              while(rs.next()) 
              {
                  String mname = rs.getString("MOV_NAME");
                  System.out.println(mname);
                  found = 1;
                  //Add result to arraylist
                  moviesNames.add(mname);
              }
              
              
              
              
              rs.close();
              stmt.close();
              conn.close();
          }//End try

          catch(SQLException se){}
          catch(Exception e){System.out.println("Done");}
        }
        
        
        
        //Add movie results to drop down menu
        for (int i=0 ; i < moviesNames.size() ; i++) //If no movies found, nothing happens
            cb.getItems().add(moviesNames.get(i));
        
        cb.setVisible(true);
        more.setVisible(true);
        
        if (found == 0) //If movie not found
        {
            System.out.println("Sorry, no movies matched with '" + input + "'");
            cb.getItems().add("0 matches");
            more.setDisable(true);
        }
        else
            more.setDisable(false);
        
      }//End if textfield not empty
      
      else //No input provided
      {
          cb.getItems().add("0 matches");
          more.setDisable(true);
      }
      
      System.out.println(moviesNames);
      found = 0; //reset that none found
   }
   
   public void processShowAll(ActionEvent event)
   {
      results.setVisible(true);
      //Every new search reset
       moviesNames.clear();
       cb.getItems().clear();
      try 
          {
              Connection conn = null;
              Statement stmt = null;
              Class.forName(JDBC_DRIVER);
              System.out.println("Connecting to database...");
              conn = DriverManager.getConnection(DB_URL,USER,PASS);
              System.out.println("Creating statement...");
              stmt = conn.createStatement();
              //String sql = "SELECT CUST_F_NAME, CUST_L_NAME FROM CUSTOMER";
              String sql = "SELECT MOV_NAME FROM MOVIE WHERE MOV_ID NOT IN(SELECT MOV_ID FROM MOVIE_RENTAL WHERE RETURNED=0) ORDER BY MOV_NAME ASC";
              ResultSet rs = stmt.executeQuery(sql);
              moviesNames.clear();

              while(rs.next()) 
              {
                  String mname = rs.getString("MOV_NAME");
                  System.out.println(mname);
                  //Add result to arraylist
                  moviesNames.add(mname);
              }
              rs.close();
              stmt.close();
              conn.close();
          }//End try

          catch(SQLException se){}
          catch(Exception e){System.out.println("Done");}
      
      for (int i=0 ; i < moviesNames.size() ; i++) //If no movies found, nothing happens
            cb.getItems().add(moviesNames.get(i));
        more.setDisable(false);
        cb.setVisible(true);
        more.setVisible(true);
      
   }
   
   public void processMore(ActionEvent event)
   {
       selectedMovie = cb.getSelectionModel().getSelectedItem().toString();
       System.out.println(selectedMovie);
       priceT.setText("Total Cost: $0.00");
       
       title.setText("Title: " + selectedMovie);
       
       try 
          {
              Connection conn = null;
              Statement stmt = null;
              Class.forName(JDBC_DRIVER);
              System.out.println("Connecting to database...");
              conn = DriverManager.getConnection(DB_URL,USER,PASS);
              System.out.println("Creating statement...");
              stmt = conn.createStatement();
              //String sql = "SELECT CUST_F_NAME, CUST_L_NAME FROM CUSTOMER";
              String sql = "SELECT * FROM MOVIE WHERE MOV_NAME='" + selectedMovie + "'";
              ResultSet rs = stmt.executeQuery(sql);
              moviesNames.clear();

              while(rs.next()) 
              {
                  mgenre = rs.getString("MOV_GENRE");
                  mdirID = Integer.parseInt(rs.getString("DIR_ID"));
                  mid = Integer.parseInt(rs.getString("MOV_ID"));
                  mprice = rs.getString("MOV_PRICE");
                  mtrailer = rs.getString("MOV_TRAILER");
                  mrest = Integer.parseInt(rs.getString("MOV_REST"));
              }
              rs.close();
              stmt.close();
              conn.close();
          }//End try

          catch(SQLException se){}
          catch(Exception e){System.out.println("Done");}
       
       
        try 
          {
              Connection conn = null;
              Statement stmt = null;
              Class.forName(JDBC_DRIVER);
              System.out.println("Connecting to database...");
              conn = DriverManager.getConnection(DB_URL,USER,PASS);
              System.out.println("Creating statement...");
              stmt = conn.createStatement();
              //String sql = "SELECT CUST_F_NAME, CUST_L_NAME FROM CUSTOMER";
              String sql = "SELECT CONCAT(DIR_F_NAME, ' ', DIR_L_NAME) AS DIR_NAME FROM DIRECTOR WHERE DIR_ID="+mdirID;
               
              ResultSet rs = stmt.executeQuery(sql);
              moviesNames.clear();

              while(rs.next()) 
              {
                  mdir = rs.getString("DIR_NAME");
              }
              rs.close();
              stmt.close();
              conn.close();
          }//End try

          catch(SQLException se){}
          catch(Exception e){System.out.println("Done");}
       
        try 
          {
              Connection conn = null;
              Statement stmt = null;
              Class.forName(JDBC_DRIVER);
              System.out.println("Connecting to database...");
              conn = DriverManager.getConnection(DB_URL,USER,PASS);
              System.out.println("Creating statement...");
              stmt = conn.createStatement();
              //String sql = "SELECT CUST_F_NAME, CUST_L_NAME FROM CUSTOMER";
              String sql = "SELECT MOV_ID FROM MOVIE WHERE MOV_ID IN(SELECT MOV_ID FROM MOVIE_RENTAL WHERE RETURNED=0) AND MOV_ID = " + mid; //Return
              ResultSet rs = stmt.executeQuery(sql);
              moviesNames.clear();

              while(rs.next()) 
              {
                  mavail++; //If it is not available
              }
              rs.close();
              stmt.close();
              conn.close();
          }//End try

          catch(SQLException se){}
          catch(Exception e){System.out.println("Done");}
        
        
       genre.setText("Genre: " + mgenre);
       director.setText("Director: " + mdir);
       price.setText("Daily rate: $" + df2.format(Double.parseDouble(mprice)));
       director.setText("Director: " + mdir);
       if (mrest==0)
           rest.setText("Age Restriction: None");
       else 
           rest.setText("Age Restriction: " + mrest);
       if (mavail==0)
       {
           avail.setText("Availability: Yes");
           rent.setDisable(false);
       }
       else 
       {
           avail.setText("Availability: No");
           rent.setDisable(true);
           mavail=0;//Update
       }
       
       
      
       primaryStage.setScene(scene2);
   }
   
   public void processBack(ActionEvent event)
   {
       if (primaryStage.getScene() == scene2)
            primaryStage.setScene(scene1);
       else
           primaryStage.setScene(scene2);
   }
   
   public void processRent(ActionEvent event)
   {
       back2.setOnAction(this::processBack);
       if (logged)
           purchase.setDisable(false);
       primaryStage.setScene(scene3);
       
   }
   
   public void processExit(ActionEvent event)
   {
       System.exit(0);
   }
  
   
   public void processLogin(ActionEvent event)
   {
       boolean done=false;
       //If not empty
      if (inCustID.getText() != null && !inCustID.getText().isEmpty() && inCustPass.getText() != null && !inCustPass.getText().isEmpty())
      {
          try 
          {
              Connection conn = null;
              Statement stmt = null;
              Class.forName(JDBC_DRIVER);
              System.out.println("Connecting to database...");
              conn = DriverManager.getConnection(DB_URL,USER,PASS);
              System.out.println("Creating statement...");
              stmt = conn.createStatement();
              //String sql = "SELECT CUST_F_NAME, CUST_L_NAME FROM CUSTOMER";
              String sql = "SELECT CUST_ID, CUST_PASS FROM CUSTOMER"; //Return
              ResultSet rs = stmt.executeQuery(sql);
              moviesNames.clear();

              while(rs.next() && !done) 
              {
                  cusid = rs.getString("CUST_ID");
                  cuspass = rs.getString("CUST_PASS");
                  
                  //Compare passwords and ids
                    if (inCustID.getText().equals(cusid) && inCustPass.getText().equals(cuspass))
                    {
                        //If succesfully logged in
                        loginM.setText("Successfully logged in");
                        loginM.setVisible(true);
                        logged = true;
                        //purchase enabled , but only do something when days seleected
                        purchase.setDisable(false);
                        done=true;
                        login.setDisable(true);
                    }
                    
              }
              rs.close();
              stmt.close();
              conn.close();
          }//End try

          catch(SQLException se){}
          catch(Exception e){System.out.println("Done");}
          
          
          if (!done) //If could not find
          {
              loginM.setText("Incorrect id or password");
              loginM.setVisible(true);
              logged = false;
              purchase.setDisable(true);
          }
          
      }
      
      else
      {
          loginM.setText("Empty fields");
          loginM.setVisible(true);
          logged = false;
          purchase.setDisable(true);
      }
   }
   
   
   public void processEstimate(ActionEvent event)
   {
       //If not empty
       if (!cbDays.getSelectionModel().isEmpty())
       {
            daysRent = Integer.parseInt(cbDays.getSelectionModel().getSelectedItem().toString());
            cost = Double.parseDouble(mprice)*daysRent*1.15; //With tax
       }
       else
           cost = 0.0;
       
       priceT.setText("Total Cost: $" + df2.format(cost));
       
   }
   
   public void processPurchase(ActionEvent event)
   {
       String returnDate=" ";
       int transID = 0;
       if (logged && !cbDays.getSelectionModel().isEmpty())//Only if logged in
       {
           //MYSQL CREATE A NEW RECORD ON MOVIE_RENTAL
           
           try 
          {
              Connection conn = null;
              Statement stmt = null;
              Class.forName(JDBC_DRIVER);
              System.out.println("Connecting to database...");
              conn = DriverManager.getConnection(DB_URL,USER,PASS);
              System.out.println("Creating statement...");
              stmt = conn.createStatement();
              //String sql = "SELECT CUST_F_NAME, CUST_L_NAME FROM CUSTOMER";
              String sql = "SELECT MAX(RENT_ID) FROM MOVIE_RENTAL"; //Return
              ResultSet rs = stmt.executeQuery(sql);

              while(rs.next()) 
              {
                  transID = Integer.parseInt(rs.getString("MAX(RENT_ID)"));
              }
              rs.close();
              stmt.close();
              conn.close();
          }//End try

          catch(SQLException se){}
          catch(Exception e){System.out.println("Done");}
           
            daysRent = Integer.parseInt(cbDays.getSelectionModel().getSelectedItem().toString());

           //Update database with new record
           try 
          {
              Connection conn = null;
              Statement stmt = null;
              Class.forName(JDBC_DRIVER);
              System.out.println("Connecting to database...");
              conn = DriverManager.getConnection(DB_URL,USER,PASS);
              System.out.println("Creating statement...");
              stmt = conn.createStatement();
              //String sql = "SELECT CUST_F_NAME, CUST_L_NAME FROM CUSTOMER";
              String sql = "INSERT INTO MOVIE_RENTAL VALUES (" + (transID+1) + ",NOW()," + daysRent + "," + mid + "," + Integer.parseInt(cusid) + "," + 0 + ")"; //RENT_ID,DATE,DAYS,MOV_ID,CUST_ID,RETURNED
              stmt.executeUpdate(sql); //Update
              
              stmt.close();
              conn.close();
          }//End try

          catch(SQLException se){}
          catch(Exception e){System.out.println("Done");}
           
           DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
           Calendar cal = Calendar.getInstance();
           cal.setTime(cal.getTime());
           cal.add(Calendar.DATE, daysRent);//Add days
           
        
         purchaseM.setText("Successfully rented " + selectedMovie + "\nTotal Cost: $" + df2.format(Double.parseDouble(mprice)*daysRent*1.15) + "\nPlease return it by " + dateFormat.format(cal.getTime()) + "\nTransaction id: " + (transID+1));
         purchaseM.setVisible(true);
         purchase.setDisable(true);
         back2.setOnAction(this::processReset);
       }
       else
       {
           //Please login in to purchase
           purchaseM.setText("Please select the days to purchase");
           purchaseM.setVisible(true);
       }
   }


   public void processTrailer(ActionEvent event)
   {
       try
       {
           java.awt.Desktop.getDesktop().browse(java.net.URI.create(mtrailer));
       } 
       catch (Exception e) {e.printStackTrace();
}
   }
   
   
   //main method
   public static void main(String[] args)
   {
      Application.launch(args);
   }
}
