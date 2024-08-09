library(dplyr)
library(tidyr)
library(lubridate)
library(readr)
setwd('/Users/henryliu/Downloads')
df <- read.csv('DBMS Main data - Sheet1.csv')

# Mapping Opponent ID
df$OpponentID <- NA
opponent_map <- data.frame(
  ID = c(10002, 10003, 10004, 10005, 10006, 10006, 10007, 10008, 10009, 10010, 
         10011, 10012, 10012, 10013, 10014, 10015, 10016, 10017, 10017, 10018, 
         10018, 10018, 10019, 10020, 10020, 10021, 
          10022, 10023, 10024, 10025, 10025, 10026, 10027, 10028, 10029, 10030, 10031, 
          10032, 10033, 10033, 10034, 10035, 10036, 10037, 10038, 10039, 10040, 10041, 
          10042, 10043, 10044, 10045, 10046, 10047, 10047, 10048, 10049, 10050, 10051, 
          10052, 10053, 10054, 10055, 10056, 10057, 10058, 10059, 10060, 10061, 
          10062, 10063, 10063, 10064, 10065, 10066, 10067, 10068, 10069, 10070, 10071, 
          10072, 10073, 10074, 10075, 10076, 10077, 10078, 10079, 10080, 10081, 
          10082, 10083, 10084, 10085, 10086, 10087, 10088, 10089, 10090, 10091, 
          10092, 10093, 10094, 10095, 10096, 10097, 10098, 10099, 10100, 10101, 
          10102, 10103, 10104, 10105, 10106, 10107, 10108, 10109, 10110, 10111, 
          10112, 10113, 10114, 10115, 10116, 10117, 10118, 10119, 10120, 10121, 
          10122, 10123, 10124, 10125, 10126, 10127, 10128, 10129, 10130, 10131, 
          10132, 10133, 10134, 10135, 10136, 10137, 10138, 10139, 10140, 10141, 
          10142, 10143, 10144, 10145, 10146, 10147, 10148),
  Name = c('Oklahoma', 'Jacksonville', 'Elon', 'Nc Greensboro', 'James Madison', 
           'JAMES MADISON',
           'Va Commonwealth', 'Howard', 'Clemson', 'Nc Asheville', 'Georgia Tech', 
           'Coppin State', 'COPPIN STATE', 'Duke', 'North Carolina', 'Richmond', 'No Carolina St', 
           'George Washington', 'GEORGE WASHINGTON', 'Maryland Eastern Shore', 'MARYLAND EASTERN SHORE',
           'Maryland-Eastern Shore', 'Virginia', 'Towson', 'TOWSON', 'UMBC', 
           'Florida State', 'Wake Forest', 'The Citadel', 'Old Dominion', 'OLD DOMINION',
           'East Carolina', 'Marist', 'Cleveland St', 'George Mason', 'Florida A&M', 
           'UMES', 'No Carolina A&T', 'West Virginia', 'WEST VIRGINIA', 'Georgetown', 'Maryland Baltimore County', 
           'Kansas St', "Mount St. Mary's", 'NC State', 'LeMoyne', 'Charleston', 
           'Marshall', 'Pace', 'Vermont', 'St Josephs Pa', 'Brown', 'William & Mary', 
           'Temple', 'TEMPLE', 'Navy', 'Penn State', 'Kentucky', 'Stetson', 'Binghamton', 
           'New York Tech', 'Delaware', 'Winthrop', 'Gardner Webb', 'Vanderbilt', 
           'Belmont', 'Lipscomb', 'Buffalo', 'Hartford', 'North Carolina State', 
           'Duquesne', 'DUQUESNE', 'Western Kentucky', 'UNCW', 'Virginia Tech', 'Bowie Baysox', 
           'Miami', 'LONGWOOD', 'Evansville', 'Boston College', 'Creighton', 
           'UCF', 'Lafayette', 'VCU', 'Coastal Carolina', 'Pittsburgh', 'Hofstra', 
           'Quinnipiac', 'La Salle', 'Florida International', 'VMI', 'Liberty', 
           'Texas', 'Army', 'Canisius', "Saint Joseph's", 'UCLA', 'Western Carolina', 
           'Purdue', 'Manhattan', "St. Peter's", "St. John's", 'Bucknell', 
           'Norfolk State', 'LSU', 'Oakland', 'Princeton', 'Rider', 'Florida', 
           'Bryant', 'Massachusetts', 'Notre Dame', 'South Carolina', 'South Alabama', 
           'Arkansas', 'Appalachian State', 'Minnesota', 'Michigan', 'Nebraska', 
           'Iowa', 'Cal State Fullerton', 'Indiana', 'Ohio State', 'Northwestern', 
           'Michigan State', 'Illinois', 'Ole Miss', 'Alabama', 'Rhode Island', 
           'Tennessee', 'Southeastern Louisiana', 'UC Irvine', 'High Point', 
           'Rutgers', 'Ball State', 'Louisville', 'Alabama State', 'Dayton', 
           'Radford', 'TBA', 'Campbell', 'Maine', 'Virginia Commonwealth', 
           'Villanova', 'Charlotte', 'Baylor', 'Indiana State', 'Cornell', 
           'Siena', 'Dallas Baptist', 'Indiana University', 'LIU', 'UConn', 
           'USF', 'Hawaii', 'Albany', 'Northeastern')
)

df$OpponentID <- opponent_map$ID[match(df$Opponent, opponent_map$Name)] 

#Mapping Location IDs
df$LocationID <- NA
location_map <- data.frame(
    ID = c(30001, 30002, 30003, 30004, 30005, 30006, 30007, 30008, 30009, 30010,
           30011, 30012, 30013, 30014, 30015, 30016, 30017, 30018, 30019, 30020,
           30021, 30022, 30023, 30024, 30025, 30026, 30027, 30028, 30029, 30030,
           30031, 30032, 30033, 30034, 30035, 30036, 30037, 30038, 30039, 30040,
           30041, 30042, 30043, 30044, 30045, 30046, 30047, 30048, 30049, 30050,
           30051, 30052, 30053, 30054, 30055, 30056, 30057, 30058, 30059, 30060,
           30061, 30062, 30063, 30064, 30065, 30066, 30067, 30068, 30069, 30070,
           30071, 30072, 30073, 30074, 30075, 30076, 30077, 30078, 30079, 30080,
           30081, 30082, 30083, 30084, 30085, 30086, 30087, 30088, 30089, 30090,
           30091, 30092, 30093, 30094, 30095, 30096, 30097, 30098, 30099, 30100,
           30101, 30102, 30103, 30104, 30105, 30106, 30107, 30108, 30109, 30110,
           30111, 30112),
    Name = c('ACC-Disney Blast Orlando', 'Elon College, N.C.', 'UNC-Greensboro', 
             'James Madison', 'VCU', 'Maryland', 'UNC-Asheville', 'Georgia Tech', 
             'Duke', 'Howard', 'Richmond, VA', 'NC State', 'Virginia', 'Richmond', 
             'College Park, MD', 'Durham, N.C.', 'Charleston, S.C.', 
             'Harmans, Md. (Joe Cannon Stadium)', 'Fairfax, VA', 'Washington, D.C.',
              'Clemson, S.C.', 'Tallahassee, FL', 'Baltimore, Md.', 'Harrisonburg, VA', 
             'Chapel Hill, N.C.', 'Winston-Salem, N.C.', 'Towson, MD', 'Charlotte, N.C.', 
             'Greensboro, N.C.', 'Atlanta, Ga.', 'Manhattan, Kan.', 'Raleigh, N.C.', 
             'Charlottesville, Va.', 'Fort Mill, S.C.', 'Williamsburg, Va.', 'Annapolis, Md.',
             'St. Petersburg, Fla.', 'DeLand, FL', 'Norfolk, Va.', 'University Park, PA',
              'Morgantown, W. Va.', 'Newark, DE', 'Salem, VA', 'Rock Hill, S.C.', 
             'Nashville, Tenn.', 'Bowie, Md.', 'Aberdeen, Md.', 'Frederick, Md.', 
             'Wilmington, N.C.', 'Miami, Fla.','Jacksonville, Fla.', 'Greenville, N.C.', 
             'Chestnut Hill, Mass.', 'Brockton, Mass.', 'Orlando, FL', 'Coral Gables, Fla.',
             'Conway, S.C.', 'Blacksburg, Va.', 'Lynchburg, Va.', 'Austin, Texas',
             'State College, Pa.', 'Los Angeles, Calif.', 'Queens, N.Y.', 'Baton Rouge, La.',
             'Gainesville, Fla.', 'Bel Air, Md. (Harford CC)', 'Aberdeen, Md. (Ripken Stadium)',
             'Pittsburgh, Pa.', 'Columbia, S.C.', 'Myrtle Beach, S.C.', 'Mobile, Ala.', 
             'Emerson, Ga.', 'Bel Air, Md.', 'Ann Arbor, Mich.', 'West Lafayette, IN', 
             'Columbus, OH', 'Evanston, IL', 'Minneapolis, Minn. (Target Field)', 
             'Los Angeles, Calif. (Jackie Robinson Stadium)', 'Tuscaloosa, Ala.',
             'Bob "Turtle" Smith Stadium', 'Irvine, Calif.', 'Fullerton, Calif.', 
             'Iowa City, IA', 'Minneapolis, Minn.', 'East Lansing, Mich.', 
             'Omaha, NE (TD Ameritrade Park)', 'Clearwater, Fla. (Spectrum Field)', 
             'Cary, N.C.', 'Piscataway, NJ', 'Lincoln, Neb.', 'Bloomington, IN', 
             'Aberdeen, Md. (Leidos Field at Ironbirds Stadium)', 'Champaign, IL', 
             'High Point, N.C.', 'Knoxville, Tenn.', 'Lafayette, LA', 
             'Urbana-Champaign, IL', 'Villanova, PA', 'Mt. Pleasant, S.C.',
             'Fluor Field (Greenville, S.C.)', 'Clark-LeClair Stadium / Greenville, N.C.',
             'Waco, TX', 'Buies Creek, NC', 'Dallas, TX', 'Omaha, NE (Charles Schwab Field)',
             'College Park, MD (Bob "Turtle" Smith Stadium)', 'Tampa, FL', 'Oxford, MS', 
             'Minneapolis, Minn. (U.S. Bank Stadium)', 'Brockton, Mass. (Campanelli Stad.)',
             'CLARK-LECLAIR STADIUM / GREENVILLE, N.C.'))

df$LocationID <- location_map$ID[match(df$Location, location_map$Name)] 

#Mapping Conference IDs

df$ConferenceID <- NA

conference_map <- data.frame(
  ID = c(20001, 20002, 20003, 20004, 20005, 20006),
  Name = c('Big Ten', 'Coastal Caroline Tournament',
          'NCAA Greenville Regional', 'NCAA College Park Regional',
          'Cambria College Classic', 'NCAA Winston-Salem Regional'))
df$ConferenceID <- conference_map$ID[match(df$Conference, conference_map$Name)] 

#Splitting Result
df <- separate(df, col = Result, into = c("Result", "Combined Score"), sep = " ")
df <- separate(df, col = 'Combined Score', into = c("Team Score", "Opponent Score"), sep = "-", 
               remove = FALSE)

#Function to create SQL Date Format Column:

convert_to_sql_date <- function(date, year) {
  date_parts <- strsplit(date, " ")[[1]]
  month_day <- paste(date_parts[1], date_parts[2])
  
  # Combine with year and convert to Date object
  date_obj <- as.Date(paste(month_day, year), "%b %d %Y")
  
  # Format to SQL date format
  format(date_obj, "%Y-%m-%d")
}


df$SQLDate <- mapply(convert_to_sql_date, df$Date, df$Year)

write.csv(df, 'DBMS Final.csv', row.names = FALSE)

