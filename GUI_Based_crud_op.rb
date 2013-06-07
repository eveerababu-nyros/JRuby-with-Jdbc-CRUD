require 'java'
require 'jdbc/mysql'

java_import 'java.awt.event.ActionListener'

module JavaSwing
	include_package 'javax.swing'
end

class GUIBasedCrud < JavaSwing::JFrame
	include ActionListener
		def initialize
			super 'CRUD Operations'
			@connection = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/jruby", "root", "root")
			@statement = @connection.createStatement
			makeTabbedJFrame
		end
		def makeTabbedJFrame
			self.setSize 400,450
			self.setDefaultCloseOperation JavaSwing::JFrame::EXIT_ON_CLOSE
			self.setLocationRelativeTo nil
			jtab = JavaSwing::JTabbedPane.new
				#creating a panel and adding some components to it
			createpanel = JavaSwing::JPanel.new
			createpanel.setLayout nil
			proid = JavaSwing::JLabel.new "Product Id:"
			proname = JavaSwing::JLabel.new "Product Name:"
			proqty = JavaSwing::JLabel.new "Product Quantity:"
			procost = JavaSwing::JLabel.new "Product Cost:"
			@proidtextfield = JavaSwing::JTextField.new 20
			@pronametextfield = JavaSwing::JTextField.new 20
			@proqtytextfield = JavaSwing::JTextField.new 20
			@procosttextfield = JavaSwing::JTextField.new 20
			productsubmit = JavaSwing::JButton.new "Save"

			#Arranging components in a panel
			proid.setBounds 20,20,200,20
			@proidtextfield.setBounds 180,18,100,30
			proname.setBounds 20,70,200,20
			@pronametextfield.setBounds 180,68,100,30
			proqty.setBounds 20,120,200,20
			@proqtytextfield.setBounds 180,118,100,30
			procost.setBounds 20,170,100,20
			@procosttextfield.setBounds 180,168,100,30

			productsubmit.setBounds 130,220,100,25
			productsubmit.addActionListener(self)

			createpanel.add proid
			createpanel.add @proidtextfield
			createpanel.add proname
			createpanel.add @pronametextfield
			createpanel.add proqty
			createpanel.add @proqtytextfield
			createpanel.add procost
			createpanel.add @procosttextfield
			createpanel.add productsubmit


				#Creating readpanel for reading data
			readpanel = JavaSwing::JPanel.new
			readpanel.setLayout nil
			productid = JavaSwing::JLabel.new "Product Id:"
			@productvalue = JavaSwing::JTextField.new 10
			getdata = JavaSwing::JButton.new "Send"
			productid.setBounds 20,20,100,25
			@productvalue.setBounds 120,20,100,25
			getdata.setBounds 70,60,100,25
			getdata.addActionListener(self)
			readpanel.add productid
			readpanel.add @productvalue	
			readpanel.add getdata

				#Displaying data

			rproid = JavaSwing::JLabel.new "Product Id:"
			rproname = JavaSwing::JLabel.new "Product Name:"
			rproqty = JavaSwing::JLabel.new "Product Quantity:"
			rprocost = JavaSwing::JLabel.new "Product Cost:"
			@proidvalue = JavaSwing::JTextField.new 20
			@proidvalue.setEditable false
			@pronamevalue = JavaSwing::JTextField.new 20
			@pronamevalue.setEditable false
			@proqtyvalue = JavaSwing::JTextField.new 20
			@proqtyvalue.setEditable false
			@procostvalue = JavaSwing::JTextField.new 20
			@procostvalue.setEditable false

			#Arranging components in a panel
			rproid.setBounds 20,120,200,20
			@proidvalue.setBounds 180,118,100,30
			rproname.setBounds 20,170,200,20
			@pronamevalue.setBounds 180,168,100,30
			rproqty.setBounds 20,220,200,20
			@proqtyvalue.setBounds 180,218,100,30
			rprocost.setBounds 20,270,100,20
			@procostvalue.setBounds 180,268,100,30


			readpanel.add rproid
			readpanel.add @proidvalue
			readpanel.add rproname
			readpanel.add @pronamevalue
			readpanel.add rproqty
			readpanel.add @proqtyvalue
			readpanel.add rprocost
			readpanel.add @procostvalue


			#Creating updatepanel for updating the data	
			updatepanel = JavaSwing::JPanel.new
			updatepanel.setLayout nil
			eproductidlabel = JavaSwing::JLabel.new "Product Id:"
			@eproductvalue = JavaSwing::JTextField.new 10
			egetdata = JavaSwing::JButton.new "Edit"
			eproductidlabel.setBounds 20,20,100,25
			@eproductvalue.setBounds 120,20,100,25
			egetdata.setBounds 70,60,100,25
			egetdata.addActionListener(self)
			updatepanel.add eproductidlabel
			updatepanel.add @eproductvalue	
			updatepanel.add egetdata

				#Displaying data

			eproid = JavaSwing::JLabel.new "Product Id:"
			eproname = JavaSwing::JLabel.new "Product Name:"
			eproqty = JavaSwing::JLabel.new "Product Quantity:"
			eprocost = JavaSwing::JLabel.new "Product Cost:"
			@eproidvalue = JavaSwing::JTextField.new 20
			@eproidvalue.setEditable false
			@epronamevalue = JavaSwing::JTextField.new 20
			@eproqtyvalue = JavaSwing::JTextField.new 20
			@eprocostvalue = JavaSwing::JTextField.new 20
			productupdate = JavaSwing::JButton.new "Update"
			
			#Arranging components in a panel
			eproid.setBounds 20,120,200,20
			@eproidvalue.setBounds 180,118,100,30
			eproname.setBounds 20,170,200,20
			@epronamevalue.setBounds 180,168,100,30
			eproqty.setBounds 20,220,200,20
			@eproqtyvalue.setBounds 180,218,100,30
			eprocost.setBounds 20,270,100,20
			@eprocostvalue.setBounds 180,268,100,30

			productupdate.setBounds 130,320,100,25
			productupdate.addActionListener(self)



			updatepanel.add eproid
			updatepanel.add @eproidvalue
			updatepanel.add eproname
			updatepanel.add @epronamevalue
			updatepanel.add eproqty
			updatepanel.add @eproqtyvalue
			updatepanel.add eprocost
			updatepanel.add @eprocostvalue
			updatepanel.add productupdate

				#Performing Operation for Delete
			deletepanel = JavaSwing::JPanel.new
			deletepanel.setLayout nil
			dproductid = JavaSwing::JLabel.new "Product Id:"
			@dproductvalue = JavaSwing::JTextField.new 10
			dgetdata = JavaSwing::JButton.new "Delete"
			dproductid.setBounds 20,20,100,25
			@dproductvalue.setBounds 120,20,100,25
			dgetdata.setBounds 70,60,100,25
			dgetdata.addActionListener(self)
			deletepanel.add dproductid
			deletepanel.add @dproductvalue	
			deletepanel.add dgetdata
			
			icon1 = JavaSwing::ImageIcon.new("images/add.png");
			icon2 = JavaSwing::ImageIcon.new("images/view.png");
			icon3 = JavaSwing::ImageIcon.new("images/edit.png");
			icon4 = JavaSwing::ImageIcon.new("images/delete.png");
			jtab.addTab("Create", icon1,  createpanel, "Performing Insert Operation")
			jtab.addTab("Read", icon2,  readpanel, "Retrieving the Records" )
			jtab.addTab("Update", icon3,  updatepanel, "Update the Record")
			jtab.addTab("Delete", icon4,  deletepanel, "Delete the Record")
			self.add jtab
			self.setVisible true
		end
		def actionPerformed event
		
			obj = event.getActionCommand
			#puts obj
		
			case obj
				when "Save"
			proid = @proidtextfield.getText.to_i
			proname = @pronametextfield.getText
			proname = "'"+proname+"'"
			proqty = @proqtytextfield.getText.to_i
			procost = @procosttextfield.getText.to_i
			begin
				result = @statement.executeUpdate("insert into products values(#{proid}, #{proname},#{proqty}, #{procost})")
				if result
					JavaSwing::JOptionPane.showMessageDialog(nil, "Record Inserted Successfully.....");
					@proidtextfield.setText ""
					@pronametextfield.setText ""
					@proqtytextfield.setText ""
					@procosttextfield.setText ""
				else
					JavaSwing::JOptionPane.showMessageDialog(nil, "Record Not Inserted");
				end
			rescue Exception => e
				puts e.message
			end	

			when "Send"
				@proidvalue.setText ""
				@pronamevalue.setText ""
				@proqtyvalue.setText ""
				@procostvalue.setText ""
				
				productidvalue = java.lang.Integer.parseInt(@productvalue.getText.chomp)				
				@productvalue.setText ""
				begin
					resultset = @statement.executeQuery("select *from products where proid = #{productidvalue.to_i.to_int}")
					while resultset.next do
						@proidvalue.setText ""+resultset.getInt("proid").to_s
						@pronamevalue.setText ""+resultset.getString("product_name")
						@proqtyvalue.setText ""+resultset.getInt("product_qty").to_s
						@procostvalue.setText ""+resultset.getInt("product_cost").to_s					
					end
				rescue Exception => e
					puts "Error"
					puts e.message
				end
			when "Edit"
				eproductidvalue = java.lang.Integer.parseInt(@eproductvalue.getText.chomp)				
				@eproductvalue.setText ""
				begin
					resultset = @statement.executeQuery("select *from products where proid = #{eproductidvalue.to_i.to_int}")
					while resultset.next do
						@eproidvalue.setText ""+resultset.getInt("proid").to_s
						@epronamevalue.setText ""+resultset.getString("product_name")
						@eproqtyvalue.setText ""+resultset.getInt("product_qty").to_s
						@eprocostvalue.setText ""+resultset.getInt("product_cost").to_s	
					end
				rescue Exception => e
					puts e.message
				end

			when "Update"
				  idvalue=	java.lang.Integer.parseInt(@eproidvalue.getText.chomp)
				  namevalue= @epronamevalue.getText 
				  namevalue = "'"+namevalue+"'"
				  qtyvalue=	java.lang.Integer.parseInt(@eproqtyvalue.getText.chomp) 
				  costvalue= java.lang.Integer.parseInt(@eprocostvalue.getText.chomp)
				
				begin
					resultset = @statement.executeUpdate("update products set product_name = #{namevalue}, product_qty = #{qtyvalue}, product_cost = #{costvalue} where proid = #{idvalue}")
					if resultset
						JavaSwing::JOptionPane.showMessageDialog(nil, "Record Updated Successfully.....");
					else
						JavaSwing::JOptionPane.showMessageDialog(nil, "Record Not Updated");
					end
				rescue Exception => e
					puts e.message
				end

					@eproidvalue.setText ""
					@epronamevalue.setText ""
					@eproqtyvalue.setText ""
					@eprocostvalue.setText ""
			when "Delete"
				begin
					dproductidvalue = java.lang.Integer.parseInt(@dproductvalue.getText.chomp)
					resultset = @statement.executeUpdate("delete from products where proid = #{dproductidvalue}")
					puts resultset
					if resultset == 1
						JavaSwing::JOptionPane.showMessageDialog(nil, "Record Deleted Successfully.....");
					else
						JavaSwing::JOptionPane.showMessageDialog(nil, "Record Not Found to Deleted");	
					end
					
				rescue Exception => e
					
					puts e.message
				end
				@dproductvalue.setText ""
			end
		end
end

GUIBasedCrud.new
