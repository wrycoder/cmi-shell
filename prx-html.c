#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv)
{
  if (argc != 3)
  {
    printf( "USAGE: prx-html [YYmmdd] [program id]\n\n"\
            "\tYYmmdd:\t\tDate of broadcast\n"\
            "\tprogram id:\tID of first program that day\n");
    return 1;  
  }

  unsigned int program_id = atol(argv[2]);
  char year[3], month[3], day[3];
  char *datestring = argv[1];
  strncpy(year, datestring, 2);
  year[2] = '\0';
  datestring += 2;
  strncpy(month, datestring, 2);
  month[2] = '\0';
  datestring += 2;
  strncpy(day, datestring, 2);
  day[2] = '\0';
  FILE *fp;
  char *link_label;
  char base_filename = 'A';
  char *filename;

  while(base_filename <= 'X')
  {
    switch(base_filename) {
      case 'A': /* N1 */
        link_label = "12:00 am";
      case 'L':
        link_label = "11:00 am";
        break;
      case 'B': /* N2 */
        link_label = "1:00 am";
        program_id += 1;
      case 'M':
        link_label = "12:00 pm";
        program_id += 1;
        break;
      case 'C': /* L1 */
        link_label = "2:00 am";
        program_id += 2;
      case 'V':
        link_label = "9:00 pm";
        program_id += 2;
        break;
      case 'D': /* N3 */
        link_label = "3:00 am";
        program_id += 3;
      case 'O':
        link_label = "2:00 pm";
        program_id += 3;
        break;
      case 'E': /* N4 */
        link_label = "4:00 am";
        program_id += 4;
      case 'P':
        link_label = "3:00 pm";
        program_id += 4;
        break;
      case 'F': /* L2 */
        link_label = "5:00 am";
        program_id += 5;
      case 'T':
        link_label = "7:00 pm";
        program_id += 5;
        break;
      case 'G': /* A1 */
        link_label = "6:00 am";
        program_id += 6;
        break;
      case 'H': /* A2 */
        link_label = "7:00 am";
        program_id += 7;
        break;
      case 'U':
        link_label = "8:00 pm";
        program_id += 7;
      case 'I': /* A3 */
        link_label = "8:00 am";
        program_id += 8;
      case 'W':
        link_label = "10:00 pm";
        program_id += 8;
        break;
      case 'J': /* L3 */
        link_label = "9:00 am";
        program_id += 9;
        break;
      case 'K': /* L4 */
        link_label = "10:00 am";
        program_id += 10;
        break;
      case 'N': /* P3 */
        link_label = "1:00 pm";
        program_id += 11;
      case 'S':
        link_label = "6:00 pm";
        program_id += 11;
        break;
      case 'Q': /* P1 */
        link_label = "4:00 pm";
        program_id += 12;
      case 'X':
        link_label = "11:00 pm";
        program_id += 12;
        break;
      default:
        link_label = "5:00 pm";
        program_id += 13;
        break;
    }
    filename = malloc(7);
    sprintf(filename, "%c.html", base_filename);
    filename[6] = '\0';
    fp = fopen(filename, "w");
    fprintf(fp, "<a href=\"https://www.blurve.net/en/preview/20%s/%s/%s.csv\">", year, month, day);
    fprintf(fp, "Download Composer 2 file</a><br><a href=\"https://www.blurve.net/en/programs/%u\">%s</a>\n", program_id, link_label);
    fflush(fp);
    fclose(fp);
    free(filename);
    program_id = atol(argv[2]);
    base_filename++;
  }
}
