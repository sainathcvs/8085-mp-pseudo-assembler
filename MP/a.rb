opcode=Hash.new
label=Hash.new
data=Hash.new
address=Hash.new
lab=Hash.new
File.open("opcodes.txt","r").each_line do |string|
	count = string.split.size
	a=string.split
	if count==3 
		opcode[a[0]]=a[1]
	end
	if count==4
		if a[1]=="Data"or a[1]=="Port-address"
			data[a[0]]=a[2]
		elsif count==4&&a[1]=="Label" 
			label[a[0]]=a[2]
		elsif count==4&&a[1]=="Address"
			address[a[0]]=a[2]
		else
			opcode[a[0]+a[1]]=a[2]
		end
	end
	if count==5 
		if a[2]=="Data"
			data[a[0]+a[1]]=a[3]
		elsif a[2]=="Address"
			address[a[0]+a[1]]=a[3]
		else
			opcode[a[0]+a[1]+a[2]]=a[3]
		end
	end
end
print "Enter the Starting address:"
strt_add=gets.to_i(16)
k=strt_add.to_i
strt_add=strt_add.to_i-1
print "\nPROGRAM:\n\n"
File.open("input.txt","r").each_line do |string1|
	p=string1.split
	count1=string1.split.size
	ac =p[0].to_s+p[1].to_s+p[2].to_s
	ac1=p[0].to_s+p[1].to_s
	if count1==1
		if(opcode.has_key?(p[0])==true)
			strt_add=(strt_add+1)
		else
			strt_add=(strt_add+1)
			lab[p[0]]=strt_add.to_s(16)
			strt_add=(strt_add-1)
		end
	else
		if(address.has_key?(p[0])==true)or(label.has_key?(p[0])==true)
			strt_add=(strt_add+3)
		elsif(address.has_key?(ac1)==true)
			strt_add=(strt_add+3)
		elsif(data.has_key?(ac1)==true)
			strt_add=(strt_add+2)
		elsif(data.has_key?(p[0])==true)
			strt_add=(strt_add+2)
		elsif(opcode.has_key?(ac)==true)
			strt_add=(strt_add+1)
		elsif(opcode.has_key?(ac1)==true)
			strt_add=(strt_add+1)
		end
	end
end
strt_add=k-1
somefile=File.open("output.txt","w")
File.open("input.txt","r").each_line do |string1|
	p=string1.split
	count1=string1.split.size
	ac =p[0].to_s+p[1].to_s+p[2].to_s
	ac1=p[0].to_s+p[1].to_s
	if count1==1
		if(opcode.has_key?(p[0])==true)
			strt_add=(strt_add+1)
			puts (strt_add).to_s(16) +  "	" +opcode[p[0]].to_s
			somefile.puts strt_add.to_s(16) +  "	" +opcode[p[0]].to_s
		else
			strt_add=(strt_add+1)
			lab[p[0]]=strt_add.to_s(16)
			strt_add=(strt_add-1)
		end
	end
	if count1==2
		if(opcode.has_key?(ac1)==true)
			strt_add=(strt_add+1)
			puts (strt_add).to_s(16) +  "	" +opcode[ac1].to_s
			somefile.puts strt_add.to_s(16) +  "	" +opcode[ac1].to_s
		end
		if(data.has_key?(p[0])==true)
			strt_add=(strt_add+1)
			puts (strt_add).to_s(16) +  "	" +data[p[0]].to_s
			somefile.puts strt_add.to_s(16) +  "	" +data[p[0]].to_s
			strt_add=(strt_add+1)
			puts (strt_add).to_s(16) +  "	" +p[1].to_s
			somefile.puts strt_add.to_s(16) +  "	" +p[1].to_s
		end
		if(label.has_key?(p[0])==true)
			strt_add=(strt_add+1)
			puts (strt_add).to_s(16)  +  "	" +label[p[0]].to_s
			somefile.puts strt_add.to_s(16)  +  "	" +label[p[0]].to_s
			strt_add=(strt_add+1)
			if(lab.has_key?(p[1])==true)
				puts (strt_add).to_s(16)+"	"+lab[p[1]].to_s[2..3]
				somefile.puts strt_add.to_s(16)+"	"+(lab[p[1]].to_s)[2..3]
				strt_add=(strt_add+1)
				puts (strt_add).to_s(16)+"	"+lab[p[1]].to_s[0..1]
				somefile.puts strt_add.to_s(16)+"	"+(lab[p[1]].to_s)[0..1]
			end
		end
		if(address.has_key?(p[0])==true)
			strt_add=(strt_add+1)
			puts (strt_add).to_s(16) +  "	" +address[p[0]].to_s
			somefile.puts strt_add.to_s(16) +  "	" +address[p[0]].to_s
			strt_add=(strt_add+1)
			puts (strt_add).to_s(16)+"	"+p[1].to_s[2..3]
			somefile.puts strt_add.to_s(16)+"	"+p[1].to_s[2..3]
			strt_add=(strt_add+1)
			puts (strt_add).to_s(16)+"	"+p[1].to_s[0..1]
			somefile.puts strt_add.to_s(16)+"	"+p[1].to_s[0..1]
		end
	end
	if count1==3
		if(opcode.has_key?(ac)==true)
			strt_add=(strt_add+1)
			puts (strt_add).to_s(16) +  "	" +opcode[ac].to_s
			somefile.puts strt_add.to_s(16) +  "	" +opcode[ac].to_s
		end
		if(data.has_key?(ac1)==true)
			strt_add=(strt_add+1)
			somefile.puts strt_add.to_s(16) + "	" +data[ac1].to_s
			puts (strt_add).to_s(16) + "	" +data[ac1].to_s
			strt_add=(strt_add+1)
			puts (strt_add).to_s(16) + "	" +p[2].to_s 
			somefile.puts strt_add.to_s(16) + "	" +p[2].to_s 
		elsif(address.has_key?(ac1)==true)
			strt_add=(strt_add+1)
			puts (strt_add).to_s(16) +  "	" +address[ac1].to_s
			somefile.puts strt_add.to_s(16) +  "	" +address[ac1].to_s
			strt_add=(strt_add+1)
			puts (strt_add).to_s(16)+"	"+p[2].to_s[2..3]
			somefile.puts strt_add.to_s(16)+"	"+p[2].to_s[2..3]
			strt_add=(strt_add+1)
			puts (strt_add).to_s(16)+"	"+p[2].to_s[0..1]
			somefile.puts strt_add.to_s(16)+"	"+p[2].to_s[0..1]

		end
	end
end
	l=gets
