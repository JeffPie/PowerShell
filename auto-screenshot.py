import os
import glob
import time
import pyautogui

# Change working directory to where PDF files are stored
os.chdir('C:\\Users\\)

# Get list of PDF files in directory
pdf_files = glob.glob('*.pdf')

# Loop through each PDF file and perform actions
for pdf_file in pdf_files:
    # Open PDF file using default program
    os.startfile(pdf_file)

    # Wait for PDF to load
    time.sleep(3)

    # Press Ctrl+\ twice to take screenshot
    pyautogui.hotkey('ctrl', '\\')
    time.sleep(1)
    pyautogui.hotkey('ctrl', '\\')
    time.sleep(1)

  # Take screenshot and save
    screenshot = pyautogui.screenshot()
    screenshot.save(r'C:\\Users\\\{}.png'.format(pdf_file))


    # Close PDF file
    pyautogui.hotkey('alt', 'f4')