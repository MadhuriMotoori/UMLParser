cp myAspect.aj sequenceDiagram.java demo.java  $1
cd $1
ajc -1.5 *.java *.aj
java demo $1 $2 $3
