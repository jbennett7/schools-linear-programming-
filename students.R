# R Programming linear Programming.
require(lpSolveAPI)
inf <- 99999      # A really large number.

# Busing Cost per Student for a school year.
costs <- c(300,0,700,inf,400,500,600,300,200,200,500,inf,0,inf,400,500,300,0)


I <- seq(1, 6, 1) # Areas
J <- c(6, 7, 8)   # Grades
K <- c(1, 2, 3)   # Schools
# There are 54 decision Variables. The problem is a minimization problem.
cost.struct <- c(rep(c(300,0,700),3),
                 rep(c(inf,400,500),3),
                 rep(c(600,300,200),3),
                 rep(c(200,500,inf),3),
                 rep(c(0,inf,400),3),
                 rep(c(500,300,0),3))

# The student makeup for Springfield School district.
#                        Areas:  A1   A2   A3   A4   A5   A6
number.of.students.per.area <- c(450, 600, 550, 350, 500, 450)
#                       Grades:   6   7   8
percentage.area.1.per.grade <- c(.32,.38,.30)
percentage.area.2.per.grade <- c(.37,.28,.35)
percentage.area.3.per.grade <- c(.30,.32,.38)
percentage.area.4.per.grade <- c(.28,.40,.32)
percentage.area.5.per.grade <- c(.39,.34,.27)
percentage.area.6.per.grade <- c(.34,.28,.38)

# Construct the model.
lprec <- make.lp(0, length(cost.struct))

# Decision variable types are integers, we cannot have half a student
set.type(lprec, 1:length(cost.struct), type=c("integer"))

# Set the objective function to the cost.structure vector
# defined above: 54 decision variables in total.
set.objfn(lprec, cost.struct)

# First set of constraints: The number of students in each area.
#   Add the constraints using sparse indices.
#   For example: Area 1 is defined by the first nine
#     decision variables.
add.constraint(lprec, c(1,1,1), "=", 450*.32, c(1,2,3))
add.constraint(lprec, c(1,1,1), "=", 450*.38, c(4,5,6))
add.constraint(lprec, c(1,1,1), "=", 450*.30, c(7,8,9))

add.constraint(lprec, c(1,1,1), "=", 600*.37, c(10,11,12))
add.constraint(lprec, c(1,1,1), "=", 600*.28, c(13,14,15))
add.constraint(lprec, c(1,1,1), "=", 600*.35, c(16,17,18))

add.constraint(lprec, c(1,1,1), "=", 550*.30, c(19,20,21))
add.constraint(lprec, c(1,1,1), "=", 550*.32, c(22,23,24))
add.constraint(lprec, c(1,1,1), "=", 550*.38, c(25,26,27))

add.constraint(lprec, c(1,1,1), "=", 350*.28, c(28,29,30))
add.constraint(lprec, c(1,1,1), "=", 350*.40, c(31,32,33))
add.constraint(lprec, c(1,1,1), "=", 350*.32, c(34,35,36))

add.constraint(lprec, c(1,1,1), "=", 500*.39, c(37,38,39))
add.constraint(lprec, c(1,1,1), "=", 500*.34, c(40,41,42))
add.constraint(lprec, c(1,1,1), "=", 500*.27, c(43,44,45))

add.constraint(lprec, c(1,1,1), "=", 450*.34, c(46,47,48))
add.constraint(lprec, c(1,1,1), "=", 450*.28, c(49,50,51))
add.constraint(lprec, c(1,1,1), "=", 450*.38, c(52,53,54))


# Second set of constraints: The capacities of each school.
#  Note this is an unbalanced transportation problem where there
#  are 2,900 students but school capacity is 3,000.
add.constraint(lprec, rep(1,18), "<=", 900, (1:54)[seq(1, 54, 3)])
add.constraint(lprec, rep(1,18), "<=", 1100, (1:54)[seq(2, 54, 3)])
add.constraint(lprec, rep(1,18), "<=", 1000, (1:54)[seq(3, 54, 3)])


#  Third set of constraints: Each school needs student make up
#  for each grade to be between 30 and 36 per cent.
#  NOTE: I could'nt get this to work because the rhs of this 
#        equation depends on the total number of students sent
#limits <- c(.30, .36)
#add.constraint(lprec, 1:6, ">=", limits[1], (1:54)[seq(1, 54, 9)])
#add.constraint(lprec, 1:6, "<=", limits[2], (1:54)[seq(1, 54, 9)])
#add.constraint(lprec, 1:6, ">=", limits[1], (1:54)[seq(2, 54, 9)])
#add.constraint(lprec, 1:6, "<=", limits[2], (1:54)[seq(2, 54, 9)])
#add.constraint(lprec, 1:6, ">=", limits[1], (1:54)[seq(3, 54, 9)])
#add.constraint(lprec, 1:6, "<=", limits[2], (1:54)[seq(3, 54, 9)])
#
#add.constraint(lprec, 1:6, ">=", limits[1], (1:54)[seq(4, 54, 9)])
#add.constraint(lprec, 1:6, "<=", limits[2], (1:54)[seq(4, 54, 9)])
#add.constraint(lprec, 1:6, ">=", limits[1], (1:54)[seq(5, 54, 9)])
#add.constraint(lprec, 1:6, "<=", limits[2], (1:54)[seq(5, 54, 9)])
#add.constraint(lprec, 1:6, ">=", limits[1], (1:54)[seq(6, 54, 9)])
#add.constraint(lprec, 1:6, "<=", limits[2], (1:54)[seq(6, 54, 9)])
#
#add.constraint(lprec, 1:6, ">=", limits[1], (1:54)[seq(7, 54, 9)])
#add.constraint(lprec, 1:6, "<=", limits[2], (1:54)[seq(7, 54, 9)])
#add.constraint(lprec, 1:6, ">=", limits[1], (1:54)[seq(8, 54, 9)])
#add.constraint(lprec, 1:6, "<=", limits[2], (1:54)[seq(8, 54, 9)])
#add.constraint(lprec, 1:6, ">=", limits[1], (1:54)[seq(9, 54, 9)])
#add.constraint(lprec, 1:6, "<=", limits[2], (1:54)[seq(9, 54, 9)])

# Fourth constraint is a non-negativity constraint.
add.constraint(lprec, 1:54, ">=", 0, 1:54)

# Solving the linear problem.
lprec
solve(lprec)
var.matrix <- matrix(get.variables(lprec),nrow=6,ncol=9,byrow=TRUE)
var.matrix

school.1.total <- sum(var.matrix[, c(1,2,3)])
school.2.total <- sum(var.matrix[, c(4,5,6)])
school.3.total <- sum(var.matrix[, c(7,8,9)])

# School Percentages.
# School 1
round(sum(var.matrix[, 1])/school.1.total, 2)
round(sum(var.matrix[, 2])/school.1.total, 2)
round(sum(var.matrix[, 3])/school.1.total, 2)


# School 2
round(sum(var.matrix[, 4])/school.2.total, 2)
round(sum(var.matrix[, 5])/school.2.total, 2)
round(sum(var.matrix[, 6])/school.2.total, 2)


# School 3
round(sum(var.matrix[, 7])/school.3.total, 2)
round(sum(var.matrix[, 8])/school.3.total, 2)
round(sum(var.matrix[, 9])/school.3.total, 2)

get.bounds(lprec)
