# Arduino IDE Environment Setup for Max1000 Board (RISC-V)

This guide provides instructions for setting up the Arduino IDE environment to develop and program the Max1000 board with RISC-V.

## Prerequisites

- Arduino IDE: Install the latest version of Arduino IDE from the official website: https://www.arduino.cc/en/software
- Max1000 Board: Obtain the Max1000 development board. More information about the board can be found on the manufacturer's website.

## Installation Steps

1. Open the Arduino IDE.
2. Go to **File** > **Preferences**.
3. In the **Additional Boards Manager URLs** field, add the following URL: https://raw.githubusercontent.com/paraplin/wavgat-board/master/package_paraplin_wavgat_index.json
																		   https://raw.githubusercontent.com/paraplin/wavgat-board/master/package_uns_max1000_index.json
4. Click **OK** to save the preferences.
5. Go to **Tools** > **Board** > **Boards Manager**.
6. In the Boards Manager window, search for "Max1000 RISC-V" and click on the result.
7. Click the **Install** button to install the Max1000 RISC-V boards package.
8. Once the installation is complete, close the Boards Manager window.
9. Go to **Tools** > **Board** and select the Max1000 RISC-V board from the list of available boards.
10. Connect the Max1000 board to your computer using a USB cable.
11. Ensure that the correct port is selected under **Tools** > **Port**.
12. You are now ready to develop and program the Max1000 board with RISC-V using the Arduino IDE.

## Examples and Resources

The Max1000 RISC-V boards package comes with a collection of example sketches and libraries to help you get started. You can access them through this scripts:
	install.py
	flow.sh

## Troubleshooting

- If you encounter any issues during the installation or programming process, refer to the troubleshooting section in the official Max1000 documentation from the Max1000 community or dr Milos Subotic.



