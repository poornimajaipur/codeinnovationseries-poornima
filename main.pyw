import database   # importing database.py(user defined) file for database interaction.
import tkinter as tk  # importing Tkinter for GUI.
from PIL import ImageTk, Image # importing PIL for rendering image.
import threading as th #importing thread for making threads
from time import sleep
        
# making connection for database
connection = database.connect()
database.Create_tables(connection)    

#Function that close the passed tkinter object and open the main window
def kill_to_main(tk_object):
	tk_object.destroy()
	menu()
#function that clear text from entry after an operation and return  number, name or nickname as string used at line 269 and 375
def setandget(check_by,entry):
    entry.set("")
    return check_by.get().strip()

# function that return rendered image.
def image_render(path):
    image = Image.open(path) 
    image = ImageTk.PhotoImage(image)
    return image

# function that insert new contact.
def insert_window():
    wel_scr.destroy()  # closing the first window
    global insert_win
    insert_win = tk.Tk() # making a tkinter object
    insert_win.title("INSERT CONTACT")  # title of window
    icon_image = Image.open("favicon.ico")      #icon For title bar
    icon_image = ImageTk.PhotoImage(icon_image) 
    insert_win.iconphoto(False, icon_image)   #function that set icon in title bar
    
    image = Image.open("insert_bg.jpg")                # Background Image for main window ----
    randered_image = ImageTk.PhotoImage(image)                                                      #
    bg_label = tk.Label(insert_win, image = randered_image)   #--------------- End Here--------------
    
    w = image_render("insert_bg.jpg").width()           # taking the height and width of bg image for size of window                                                           
    h = image_render("insert_bg.jpg").height()                                                                    #
    insert_win.geometry('%dx%d+0+0' % (w,h))                             # setting the size of window equal to bg image size)
    insert_win.maxsize(w,h)          #restricting the window to be maximize
    name =  tk.StringVar()  #variable for storing name passed from name entry
    number =  tk.StringVar() #variable for storing number passed from number entry
    nickname = tk.StringVar() #variable for storing nickname passed from nickname entry
    # Entry and Label for name .
    name_entry = tk.Entry(
        insert_win,
        font = ("Arial", 12,"bold"),
        bd = 0, 
        bg = "#1c1c1a",
        width = 27,
        fg = "white",
        textvariable = name)
    name_label = tk.Label(
        insert_win, 
        text = "NAME :", 
        bg = "white", 
        font = ("Times new roman", 15),)
    
    # Entry and Label for Number
    number_entry = tk.Entry(
        insert_win,
        font = ("Arial", 12,"bold"),
        bd = 0, 
        bg = "#1c1c1a",
        width = 10,
        fg = "white",
        textvariable = number)
    number_label = tk.Label(
        insert_win, 
        text = "NUMBER :", 
        bg = "white", 
        font = ("Times new roman", 15),)
    
    # Entry and Label for Nickname
    nickname_entry = tk.Entry(
        insert_win,
        font = ("Arial", 12,"bold"),
        bd = 0, 
        bg = "#1c1c1a",
        width = 10,
        fg = "white",
        textvariable = nickname)
    nickname_label = tk.Label(
        insert_win, 
        text = "NICKNAME :", 
        bg = "white", 
        font = ("Times new roman", 15),)
    #Function that add contact to database and clear the entrys
    def add_contact():
        database.add_contact(connection, name.get().strip(),  # passing values to addcontact function
        number.get().strip(),
        nickname.get().strip())
        name.set("")
        number.set("")
        nickname.set("")
    # insert button for appending data in database
    button_image = Image.open("insert.png")
    r_button_image = ImageTk.PhotoImage(button_image)
    insert_button = tk.Button(insert_win,
        image = r_button_image,
        relief = tk.FLAT,
        bd = 0, 
        command = lambda:add_contact(), 
        )
    #Button for going back to main window
    back_button = tk.Button(
        master=insert_win,
        text = "Back",
        bd = 0,
        relief  = tk.FLAT,
        command = lambda:kill_to_main(insert_win),
        bg = "#d8d8d8",
        padx = 20,
        pady = 15,
        
    )
    
    insert_button.place(x = 410, y = 370,height = 70, width = 160) # placing all label and widgets in window 
    nickname_entry.place(x = 440, y = 230,height = 30,width = 200)                                        #
    nickname_label.place(x = 299, y = 230)                                                                #
    number_label.place(x = 299, y = 140)                                                                  #
    number_entry.place(x = 400, y = 140,height = 30,width = 240)                                          #
    name_label.place(x = 300, y = 60)                                                                     #
    name_entry.place(x = 395, y = 60,height = 30)                                                         #
    bg_label.place(x = 0, y = 0)                                                                          #
    back_button.place(x = 585, y = 525)                                                          # end here
    insert_win.mainloop()

# Function that search contact
def search_window():
    wel_scr.destroy()  #closing the first window
    global search_win
    search_win = tk.Tk() #making a tkinter object
    search_win.title("SEARCH CONTACT")  #title of window
    icon_image = Image.open("favicon.ico")      #icon For title bar
    icon_image = ImageTk.PhotoImage(icon_image) 
    search_win.iconphoto(False, icon_image)   #function that set icon in title bar
    
    image = Image.open("insert_bg.jpg")                # Background Image for main window ----
    randered_image = ImageTk.PhotoImage(image)                                                      #
    bg_label = tk.Label(search_win, image = randered_image)   #--------------- End Here--------------#
    
    w = image_render("insert_bg.jpg").width()           # taking the height and width of bg image for size of window                                                           
    h = image_render("insert_bg.jpg").height()                                                                    #
    search_win.geometry('%dx%d+0+0' % (w,h))                             # setting the size of window equal to bg image size
    search_win.maxsize(w,h)     #restricting the window to be maximize\
    
    check_by = tk.StringVar()  # variable that store user selection for searching by name, number or nickname
    check_by.set("name")    # setting variable to name radio button
    global entry
    entry = tk.StringVar() # variable that store user entry for searching
    
    #name radio_button
    name_radio_button = tk.Radiobutton(search_win,
     text = "Name", 
     value = "name",
     variable = check_by,
     command = lambda:check_by.set("name")
     )
     #number radio_button
    number_radio_button = tk.Radiobutton(search_win,
     text = "Number",
     value = "number",
     variable = check_by,
     command = lambda:check_by.set("number")
     )
    # nickname radio_button
    nickname_radio_button = tk.Radiobutton(search_win,
    text = "Nickname",
    value = "nickname",
    variable = check_by,
    command = lambda:check_by.set("nickname"),
    )
    #Entry and Label for searching
    s_entry = tk.Entry(
        search_win,
        font = ("Arial", 12,"bold"),
        bd = 0, 
        bg = "#1c1c1a",
        width = 27,
        fg = "white",
        textvariable = entry,
    )
    s_entry_label = tk.Label(
    search_win, 
    text = "Entry :", 
    bg = "white", 
    font = ("Times new roman", 18,"bold"),)
    #label for searching option
    opt_label = tk.Label(search_win,
    text = "Search By: ",
    font = ("Times new roman", 12),
    bg = "white"
    )
    
    # back Button
    back_button = tk.Button(
    master=search_win,
    text = "Back",
    bd = 0,
    relief  = tk.FLAT,
    command = lambda:kill_to_main(search_win),
    bg = "#d8d8d8",
    padx = 20,
    pady = 15,
    )
    #list box for search recommandation
    re_listbox = tk.Listbox(search_win,
    height = 5,  
    width = 40,  
    bg = "#d8d8d8", 
    activestyle = 'dotbox',  
    )
    # Function that set search entry with listbox current selection
    def set_entry():
        try:
            selected = re_listbox.curselection()
        except:
            pass
        if len(selected) > 0:
            selected = re_listbox.get(selected[0])
            entry.set(selected)
    # Function that shows search recommandation in listbox using thread
    def show_recommandation(check_by): 
        connection = database.connect()
        database.Create_tables(connection)  
        while(True):
            try:
                focus = str(search_win.focus_get())   #check that if entry is selected or not
            except Exception as e:
                pass
            if focus == ".!entry":
                try:
                    re_listbox.place(x = 395, y = 90)  #if entry is selected then place hidden listbox
                except Exception as e:
                    pass
                word = " "
                try:
                    re_listbox.delete(0, re_listbox.size()) #deleting entry of listbox in their is no word in entry
                except:
                    pass
                i = 0
                while(word):
                   try:
                       re_listbox.bind_all("<Double-Button-1>",set_entry())  #binding mouse button to listbox selection(on click selection will be wrote in search entry)
                   except:
                       pass
                   word = str(entry.get())
                   list_re = database.search_recom(connection, word, check_by) #getting data from database for recommandation
                   try:
                       re_listbox.insert(i, list_re[i][0])  #inserting item in listbox for recommandation
                       i += 1
                       sleep(1)
                   except Exception as e:
                       pass
                       break
            else:
                try:
                    re_listbox.place_forget() #Hiding list box when entry is not selected.
                except:
                    pass
    #making thread for showing recommandation 
    search_thread = th.Thread(target = show_recommandation, args = (check_by,), daemon = True)
    #starting thread
    search_thread.start()
    #image for search Button
    search_image = Image.open("search.png")
    search_image = ImageTk.PhotoImage(search_image)
    #button for searching
    search_button = tk.Button(search_win,
    text = "Search",
    image = search_image,
    relief = tk.FLAT,
    bd = 0,
    command = lambda:database.search_by_choice(connection,entry.get().strip(),setandget(check_by,entry),
    ))
    #recent search list
    #recent_list = tk.Listbox(search_win,
    #bg = "#1c1c1a",
    #fg = "white",
    #font = ("Arial", 8,"bold"),
    #)
    

    bg_label.place(x = 0, y = 0)                  #placing all the widegts in main window
    name_radio_button.place(x = 400, y = 250)                                           #
    number_radio_button.place(x = 470, y = 250)                                         #
    nickname_radio_button.place(x = 565, y = 250)                                       #
    s_entry.place(x = 395, y = 60,height = 30)                                          # 
    back_button.place(x = 585, y = 525)                                                 #
    opt_label.place(x = 300, y= 250)                                                    #
    s_entry_label.place(x = 300, y = 59)                                                #
    #recent_list.place(x = 400, y = 160,width = 235)
    search_button.place(x = 410, y = 370,height = 70, width = 160)               #end here  
    search_win.mainloop()

# Function that delete contact
def delete_window():
    wel_scr.destroy()  # closing the first window
    global delete_win
    delete_win = tk.Tk() # making a tkinter object
    delete_win.title("DELETE CONTACT")  # title of window
    icon_image = Image.open("favicon.ico")      #icon For title bar
    icon_image = ImageTk.PhotoImage(icon_image) 
    delete_win.iconphoto(False, icon_image)   #function that set icon in title bar
    
    image = Image.open("insert_bg.jpg")                # Background Image for main window ----
    randered_image = ImageTk.PhotoImage(image)                                                      #
    bg_label = tk.Label(delete_win, image = randered_image)   #--------------- End Here--------------
    
    w = image_render("insert_bg.jpg").width()           # taking the height and width of bg image for size of window                                                           
    h = image_render("insert_bg.jpg").height()                                                                    #
    delete_win.geometry('%dx%d+0+0' % (w,h))                             # setting the size of window equal to bg image size
    delete_win.maxsize(w,h)       #restricting the window to be maximize
    delete_by = tk.StringVar()  # variable that store user selection for delete by name, number or nickname
    delete_by.set("name")    # setting variable to name radio button
    global entry
    entry = tk.StringVar() # variable that store user entry for deleting
    #name radio_button
    name_radio_button = tk.Radiobutton(delete_win,
     text = "Name", 
     value = "name",
     variable = delete_by,
     command = lambda:delete_by.set("name")
     )
     #number radio_button
    number_radio_button = tk.Radiobutton(delete_win,
     text = "Number",
     value = "number",
     variable = delete_by,
     command = lambda:delete_by.set("number")
     )
    # nickname radio_button
    nickname_radio_button = tk.Radiobutton(delete_win,
    text = "Nickname",
    value = "nickname",
    variable = delete_by,
    command = lambda:delete_by.set("nickname"),
    )
    #Entry and Label for deleting
    d_entry = tk.Entry(
        delete_win,
        font = ("Arial", 12,"bold"),
        bd = 0, 
        bg = "#1c1c1a",
        width = 27,
        fg = "white",
        textvariable = entry,
    )
    d_entry_label = tk.Label(
    delete_win, 
    text = "Entry :", 
    bg = "white", 
    font = ("Times new roman", 18,"bold"),)
    #label for searching option
    opt_label = tk.Label(delete_win,
    text = "Delete By: ",
    font = ("Times new roman", 12),
    bg = "white"
    )
    
    # back Button
    back_button = tk.Button(
    master=delete_win,
    text = "Back",
    bd = 0,
    relief  = tk.FLAT,
    command = lambda:kill_to_main(delete_win),
    bg = "#d8d8d8",
    padx = 20,
    pady = 15,
    )
    #image for search Button
    delete_image = Image.open("delete.png")
    delete_image = ImageTk.PhotoImage(delete_image)
    #button for searching
    delete_button = tk.Button(delete_win,
    image = delete_image,
    relief = tk.FLAT,
    bd = 0,
    command = lambda:database.delete_by_choice(connection,entry.get().strip(),setandget(delete_by,entry),
    ))

    bg_label.place(x = 0 , y = 0)                   #placing all the widgets in window
    name_radio_button.place(x = 400, y = 120)                                           #
    number_radio_button.place(x = 470, y = 120)                                         #
    nickname_radio_button.place(x = 565, y = 120)                                       #
    d_entry.place(x = 395, y = 60,height = 30)                                          # 
    back_button.place(x = 585, y = 525)                                                 #
    opt_label.place(x = 300, y= 120)                                                    #
    d_entry_label.place(x = 300, y = 59)                                                #
    delete_button.place(x = 410, y = 370,height = 70, width = 160)              #end here
    delete_win.mainloop()

def update_window():
    wel_scr.destroy()  # closing the first window
    global update_win
    update_win = tk.Tk() # making a tkinter object
    update_win.title("UPDATE CONTACT")  # title of window
    icon_image = Image.open("favicon.ico")      #icon For title bar
    icon_image = ImageTk.PhotoImage(icon_image) 
    update_win.iconphoto(False, icon_image)   #function that set icon in title bar
    
    image = Image.open("insert_bg.jpg")                # Background Image for main window ----
    randered_image = ImageTk.PhotoImage(image)                                                      #
    bg_label = tk.Label(update_win, image = randered_image)   #--------------- End Here--------------
    
    w = image_render("insert_bg.jpg").width()           # taking the height and width of bg image for size of window                                                           
    h = image_render("insert_bg.jpg").height()                                                                    #
    update_win.geometry('%dx%d+0+0' % (w,h))                             # setting the size of window equal to bg image size
    update_win.maxsize(w,h)       #restricting the window to be maximize
    contact_to_update = tk.StringVar()
    name =  tk.StringVar()  #variable for storing name passed from name entry
    number =  tk.StringVar() #variable for storing number passed from number entry
    nickname = tk.StringVar() #variable for storing nickname passed from nickname entry
    
    #listbox that contain all contact
    contact_listbox = tk.Listbox(update_win,
    height = 30,  
    width = 40,  
    bg = "#d8d8d8",
    activestyle = 'dotbox',
    )
    #Scroll Bar for listbox
    contact_scrollbar = tk.Scrollbar(update_win,
    )
    contact_listbox.config(yscrollcommand = contact_scrollbar.set)
    contact_scrollbar.config(command = contact_listbox.yview)
    #Label for showing name of contact to be updated
    update_name_label = tk.Label(
    update_win,
    text= "Select Contact To Update:", 
    bg = "white", 
    font = ("Times new roman", 14),
    )
    #Function used by thread for getting user selection
    def set_contact_to_up():
        while True:
            try:
                cur_sel = contact_listbox.curselection() #getting user selection
                cur_sel = cur_sel[0] #selecting the first item index
                cur_sel = str(contact_listbox.get(cur_sel)) #getting the item
                cur_sel = cur_sel.split(" ") #making list of selection for filling in entrys
                contact_to_update.set(cur_sel[1]) #getting name of contact who is gone be update
                nickname.set(cur_sel[3]) #setting all entrys with current selected contact
                name.set(cur_sel[1])
                number.set(cur_sel[2])
                cur_sel = "Enter New Detail For {} :".format(cur_sel[1]) #setting info label text for a selected contact
                update_name_label.update()
                update_name_label.configure(text = cur_sel)   
            except Exception as e:
                pass
#funciton that insert contacts in listbox in this format (if/name/number/nickname)
    def fill_list():
        for i,z in enumerate(database.get_all_contact(connection)):
            try:
                contact_listbox.insert(i, str(z[0])+ " "+ z[1]+ " "+ z[2]+ " "+z[3])  #inserting item in listbox for recommandation
            except Exception as e:
                print(e)
                break
    fill_list() #Filling Listbox with contacts

    # Entry and Label for name.
    name_entry = tk.Entry(
        update_win,
        font = ("Arial", 12,"bold"),
        bd = 0, 
        bg = "#1c1c1a",
        width = 27,
        fg = "white",
        textvariable = name)
    name_label = tk.Label(
        update_win, 
        text = "NEW NAME :", 
        bg = "white", 
        font = ("Times new roman", 12),)
    # Entry and Label for Number.
    number_entry = tk.Entry(
        update_win,
        font = ("Arial", 12,"bold"),
        bd = 0, 
        bg = "#1c1c1a",
        width = 10,
        fg = "white",
        textvariable = number)
    number_label = tk.Label(
        update_win, 
        text = "NEW NUMBER :", 
        bg = "white", 
        font = ("Times new roman", 12),)
    
    # Entry and Label for Nickname.
    nickname_entry = tk.Entry(
        update_win,
        font = ("Arial", 12,"bold"),
        bd = 0, 
        bg = "#1c1c1a",
        width = 10,
        fg = "white",
        textvariable = nickname,)
    nickname_label = tk.Label(
        update_win, 
        text = "NEW NICKNAME :", 
        bg = "white", 
        font = ("Times new roman", 12),)
    #thread thats get user selection in background and use set_contact_to_up function
    thread_ = th.Thread(target=set_contact_to_up,daemon=True)
    thread_.start()
#Function that update contact in database and clear entrys also set info label with its default value
    def update_and_task():
            database.update_contact(connection,str(name.get()).strip(" "),
            str(number.get()).strip(" "),
            str(nickname.get()).strip(" "),
            str(contact_to_update.get()))
            contact_listbox.delete(0,contact_listbox.size()) #removing previous data from listbox
            fill_list() #After clicking on update button filling the listbox again with new data
            name.set("")
            number.set("")
            nickname.set("")
            update_name_label.update()
            update_name_label.configure(text = "Select Contact To Update:")   
    # update button for updating data in database.
    button_image = Image.open("update.png")
    button_image = ImageTk.PhotoImage(button_image)
    update_button = tk.Button(update_win,
        image = button_image,
        relief = tk.FLAT,
        bd = 0, 
        command = lambda:update_and_task(), # passing values to addcontact function
        )
    #Button for going back to main window
    back_button = tk.Button(
        master=update_win,
        text = "Back",
        bd = 0,
        relief  = tk.FLAT,
        command = lambda:kill_to_main(update_win),
        bg = "#d8d8d8",
        padx = 20,
        pady = 15,   
    )

    
    update_button.place(x = 410, y = 370,height = 70, width = 160)      #placing all the widgets in window
    contact_scrollbar.place(x = 246, y = 60)                                                              #
    update_name_label.place(x = 300, y = 110)                                                             #
    bg_label.place(x = 0 , y = 0)                                                                         #
    nickname_entry.place(x = 440, y = 280,height = 25,width = 210)                                        #
    nickname_label.place(x = 299, y = 280)                                                                #
    number_label.place(x = 299, y = 210)                                                                  #
    number_entry.place(x = 430, y = 210,height = 25,width = 220)                                          #
    name_label.place(x = 300, y = 150)                                                                    #
    name_entry.place(x = 405, y = 150,height = 25)                                                        #
    contact_listbox.place(x = 20, y = 60)                                                                 #
    back_button.place(x = 585, y = 525)                                                           #END HERE
    update_win.mainloop() #mainloop of update window
#Function for the main window
def menu():  
    global wel_scr
    wel_scr = tk.Tk() #making a tkinter object
    wel_scr.title("Contact Saver By D")  #title of application
    icon_image = Image.open("favicon.ico")      #icon For title bar
    icon_image = ImageTk.PhotoImage(icon_image) 
    wel_scr.iconphoto(False, icon_image)   #function that set icon in title bar
    
    image = Image.open("BG.jpg")                            # Background Image for main window ----
    randered_image = ImageTk.PhotoImage(image)                                                            #
    bg_label = tk.Label(master=wel_scr, image = randered_image)   #--------------- End Here--------------
    
    w = image_render("BG.jpg").width()                      #taking the height and width of bg image for size of window                                                           
    h = image_render("BG.jpg").height()                                                                                #
    wel_scr.geometry('%dx%d+0+0' % (w,h))                   # setting the size of window equal to bg image size
    wel_scr.minsize(655,784)
    wel_scr.maxsize(655,784)

    # Button for inserting contact
    insert_button = tk.Button(
        wel_scr,
        text = "INSERT NEW CONTACT", 
        bg = "black",
        fg = "white",
        padx = 20,
        pady = 20,
        font = ("Arial", 12, "bold"),
        command = insert_window
        )
    
    # Button for searching contact
    search_button = tk.Button(
        wel_scr,
        text = "SEARCH CONTACT", 
        bg = "black",
        fg = "white",
        padx = 36.5,
        pady = 20,
        font = ("Arial", 12, "bold"),
        command = search_window
        )
    
    # Button for deleting contact 
    delete_button = tk.Button(
        wel_scr,
        text = "DELETE CONTACT", 
        bg = "black",
        fg = "white",
        padx = 36.5,
        pady = 20,
        font = ("Arial", 12, "bold"),
        command = delete_window
        )
    #Button for updating contact
    update_button = tk.Button(
        wel_scr,
        text = "UPDATE CONTACT", 
        bg = "black",
        fg = "white",
        padx = 36.5,
        pady = 20,
        font = ("Arial", 12, "bold"),
        command = update_window,
        )
    # placing all the button in main window.
    update_button.place(x = 23, y = 600)
    delete_button.place(x = 23, y = 420)
    search_button.place(x = 23, y = 240)
    insert_button.place(x = 23, y = 80)
    bg_label.place(x = 0, y = 0)
    wel_scr.mainloop()   # mainloop always required.

#calling the main function
menu()