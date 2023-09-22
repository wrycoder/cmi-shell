/**
 * prx-rename.c
 *
 * Command-line utility for renaming a collection of .MP2 files
 *
 */

#include <stdio.h>
#include <combaseapi.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <stdbool.h>
#include <string.h>
#include <strsafe.h>
#include <dirent.h>
#include <assert.h>

bool file_exists(const char *filename) 
{
  struct stat buffer;
  return stat(filename, &buffer) == 0 ? true : false;
}

const char *letters[] =
{
  "A",          "B",          "C",         "D",         "E",          "F",
  "G",          "H",          "I",         "J",         "K",          "K",
  "M",          "N",          "O",         "P",         "Q",          "R",
  "S",          "T",          "U",         "V",         "W",          "X"
};

const char *hours[] =
{
  "N1",         "N2",         "L1",        "N3",        "N4",         "L2",
  "A1",         "A2",         "A3",        "L3",        "L4",         "N1",
  "N2",         "P3",         "N3",        "N4",        "P1",         "P2",
  "P3",         "L2",         "A2",        "L1",        "A3",         "P1"
};

const char *airtimes[] =
{
  "12AM or 11AM", "1AM or 12PM", "2AM or 9PM", "3AM or 2PM", "4AM or 3PM", "5AM or 7PM",
  "6AM",         "7AM or 8PM",  "8AM or 10PM", "9AM",       "10AM",         "12AM or 11AM",
  "1AM or 12PM", "1PM or 6PM",  "3AM or 2PM",  "4AM or 3PM",  "4PM or 11PM", "5PM",
  "1PM or 6PM",  "5AM or 7PM",  "7AM or 8PM",  "2AM or 9PM",  "8AM or 10PM", "4PM or 11PM"
};

const char *segments[] = { "SEG 3", "SEG 4", "SEG 5", "SEG 6", "SEG 7" };

int main(int argc, char **argv)
{
  if (argc != 3) 
  {
    printf( "USAGE: %s [digit] [day]\n\n"\
            "* [digit] is the episode number for the day you want to publish\n"\
            "* [day] is a three-letter abbreviation for the day of the week\r\n", argv[0]);
    return 1;
  } 
    else 
  {
    char *billboard_cmd = "copy CMI-%s%s-1.mp2 \"%s.%s %s BILLBOARD.mp2\"";
    char *newshole_cmd = "copy CMI-%s%s-2.mp2 \"%s.%s %s NEWS HOLE.mp2\"";
    char *segment_cmd = "copy CMI-%s%s-%d.mp2 \"%s.%s %s %s.mp2\"";
    char *cmdbuf;
    size_t buffer_size;
    for(int i = 0; i < 24; i++) 
    {
      buffer_size = strlen(billboard_cmd) + strlen("DAY") + strlen(letters[i]) + strlen(hours[i]) + strlen(airtimes[i]) + sizeof(char);
      cmdbuf = (char *)CoTaskMemAlloc(buffer_size);
      StringCbPrintfA(cmdbuf, buffer_size, billboard_cmd, hours[i], argv[2], argv[1], letters[i], airtimes[i]);
      printf(cmdbuf);
      system(cmdbuf);
      CoTaskMemFree(cmdbuf);
      buffer_size = strlen(newshole_cmd) + strlen("DAY") + strlen(letters[i]) + strlen(hours[i]) + strlen(airtimes[i]) + sizeof(char);
      StringCbPrintfA(cmdbuf, buffer_size, newshole_cmd, hours[i], argv[2], argv[1], letters[i], airtimes[i]);
      printf(cmdbuf);
      system(cmdbuf);
      CoTaskMemFree(cmdbuf);
      for(int x = 0; x < 5; x++) {
        char filename[35];
        StringCbPrintfA(filename, 35, "CMI-%s%s-%d.mp2", hours[i], argv[2], (x+3));
        if (file_exists(filename))
        {
          buffer_size = strlen(segment_cmd) + strlen("DAY") + strlen(letters[i]) + strlen(hours[i]) + strlen(airtimes[i]) + strlen(segments[x]) + sizeof(char);
          cmdbuf = (char *)CoTaskMemAlloc(buffer_size);
          StringCbPrintfA(cmdbuf, buffer_size, segment_cmd, hours[i], argv[2], (x+3), argv[1], letters[i], airtimes[i], segments[x]);
          printf(cmdbuf);
          system(cmdbuf);
          CoTaskMemFree(cmdbuf);
        }
      }
    }
    printf("All files copied.\r\n");
    return 0;
  }
}
