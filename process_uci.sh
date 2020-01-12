#cat /code/media/chess/kingbase-ftfy.txt | ./pgn-extract  -Wxlalg -w99999999 2>/dev/null 
#cat /code/media/chess/kingbase-ftfy.txt | ./pgn-extract  -Welalg -w99999999 2>/dev/null 
#cat /code/media/chess/kingbase-ftfy.txt | ./pgn-extract  -Wlalg -w99999999 2>/dev/null 
#cat /code/media/chess/kingbase-ftfy.txt | \
#  ./pgn-extract -Wuci -w99999999 2>/dev/null | \
#  egrep '^[^\[]' | \
#  sed -e 's/ //g' | \
#  sed -e 's/\(.*\)0-1/0-1 \1 0-1/g' | \
#  sed -e 's/\(.*\)1-0/1-0 \1 1-0/g' | \
#  sed -e 's/\(.*\)1.2-1.2/1\/2 \1 1\/2/g'

cat /code/media/chess/kingbase-ftfy.txt | \
  ./pgn-extract -Wuci -w99999999 2>/dev/null | \
  egrep '^[^\[]' | \
  #sed -e 's/ //g' | \
  sed -e 's/\(.*\)0-1/>\1>/g' | \
  sed -e 's/\(.*\)1-0/<\1</g' | \
  sed -e 's/\(.*\)[ ]*1.2-1.2[ ]*/|\1|/g' | \
  python3 -c '
import sys;
i = 0
for line in sys.stdin:
  i += 1
  line = line.strip()
  c = line[0]
  #assert(line[-1] == c)
  if line[-1] != c:
    print("Invalid line %d: %s" % (i, repr(line)))
  else:
    line = line[1:-1]
    line = c+c.join(line.split(" "))+c
    print(line)
'
