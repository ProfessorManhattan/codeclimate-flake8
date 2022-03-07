from tkinter import *
class Hello:
    def __init__(self, parent):
        self.master = parent
        parent.title("Hello Tkinter")
        self.label = Label(parent, text="Hello there")
        self.label.pack()
        self.close_button = Button(parent, text="Close",
                                   command=parent.quit)
        self.close_button.pack()
    def greet(self):
        print("Greetings!")
root = Tk()
my_gui = Hello(root)
root.mainloop()
