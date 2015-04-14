//
//  ASStudent.m
//  ASTableViewSearch
//
//  Created by Alex Sergienko on 28.02.15.
//  Copyright (c) 2015 Alexandr Sergienko. All rights reserved.
//

#import "ASStudent.h"
#import "NSDate+ASRandomStudentAge.h"

static const NSInteger studentsCount = 100;

static const NSInteger bazingaPhrasesCount = 11;

static NSString *firstNames[] = {
    
    @"Jackson", @"Aiden", @"Aiden", @"Liam", @"Lucas", @"Noah", @"Mason", @"Jayden", @"Ethan", @"Jacob",
    @"Jack", @"Caden", @"Logan", @"Benjamin", @"Michael", @"Caleb", @"Ryan", @"Alexander", @"Elijah",
    @"James", @"William", @"Oliver", @"Connor", @"Matthew", @"Daniel", @"Luke", @"Brayden", @"Jayce",
    @"Henry", @"Carter", @"Dylan", @"Gabriel", @"Joshua", @"Nicholas", @"Isaac", @"Owen", @"Nathan",
    @"Grayson", @"Eli", @"Landon", @"Andrew", @"Max", @"Samuel", @"Gavin", @"Wyatt", @"Christian",
    @"Hunter", @"Cameron", @"Evan", @"Charlie", @"David", @"Sebastian", @"Joseph", @"Dominic", @"Anthony",
    @"Colton", @"John", @"Tyler", @"Zachary", @"Thomas", @"Julian", @"Levi", @"Adam", @"Isaiah", @"Alex",
    @"Aaron", @"Parker", @"Cooper", @"Miles", @"Chase", @"Muhammad", @"Christopher", @"Blake", @"Austin",
    @"Jordan", @"Leo", @"Jonathan", @"Adrian", @"Colin", @"Hudson", @"Ian", @"Xavier", @"Camden",
    @"Tristan", @"Carson", @"Jason", @"Nolan", @"Riley", @"Lincoln", @"Brody", @"Bentley", @"Nathaniel",
    @"Josiah", @"Declan", @"Jake", @"Asher", @"Jeremiah", @"Cole", @"Mateo", @"Micah", @"Elliot"
    
    
};

static NSString *lastNames[] = {
    
    @"Smith", @"Johnson", @"Williams", @"Jones", @"Brown", @"Davis", @"Miller", @"Wilson", @"Moore",
    @"Taylor", @"Anderson", @"Thomas", @"Jackson", @"White", @"Harris", @"Martin", @"Thompson", @"Garcia",
    @"Martinez", @"Robinson", @"Clark", @"Rodriguez", @"Lewis", @"Lee", @"Walker", @"Hall", @"Allen",
    @"Young", @"Hernandez", @"King", @"Wright", @"Lopez", @"Hill", @"Scott", @"Green", @"Adams", @"Baker",
    @"Gonzalez", @"Nelson", @"Carter", @"Mitchell", @"Perez", @"Roberts", @"Turner", @"Phillips",
    @"Campbell", @"Parker", @"Evans", @"Edwards", @"Collins", @"Stewart", @"Sanchez", @"Morris", @"Rogers",
    @"Reed", @"Cook", @"Morgan", @"Bell", @"Murphy", @"Bailey", @"Rivera", @"Cooper", @"Richardson",
    @"Cox",@"Howard", @"Ward", @"Torres", @"Peterson", @"Gray", @"Ramirez", @"James", @"Watson", @"Brooks",
    @"Kelly", @"Sanders", @"Price", @"Bennett", @"Wood", @"Barnes", @"Ross", @"Henderson", @"Coleman",
    @"Jenkins", @"Perry", @"Powell", @"Long", @"Patterson", @"Hughes", @"Flores", @"Washington", @"Butler",
    @"Simmons", @"Foster", @"Gonzales", @"Bryant", @"Alexander", @"Russell", @"Griffin", @"Diaz", @"Hayes"
};

static NSString *bazingaPhrases [] = {
    
    @"На моём новом компьютере стоит Windows 7. В ней более дружелюбный интерфейс, чем в Windows Vista. Мне это не нравится…",
    @"Нашу квартиру ограбили, наша система безопасности чуть не лишила меня жизни. И все это заставляет меня переехать из Пасадены. Скажи мне, где тут чересчур?",
    @"Небольшое недопонимание? Это у Галилео и Папы Римского было небольшое недопонимание!",
    @"Прошу прощения, я бы вернулся раньше, но автобус сделал остановку, чтобы впустить людей.",
    @"That is my spot. In an ever-changing world it is a simple point of consistency. If my life were expressed as a function in a four-dimensional Cartesian coordinate system, that spot, at the moment I first sat on it, would be [0,0,0,0].",
    @"Bazinga!:)",
    @"The X-man were named for the X in Charles Xavier since i'am Sheldon Cooper you will be my C-man:)",
    @"What computer do you have and please don’t say a white one?",
    @"Scissors cuts paper. Paper covers rock. Rock crushes lizard. Lizard poisons Spock. Spock smashes scissors. Scissors decapitates lizard. Lizard eats paper. Paper disproves Spock. Spock vaporizes rock. And, as it always has, rock crushes scissors.",
    @"Soft kitty, warm kitty, little ball of fur, happy kitty, sleepy kitty, purr purr purr.",
    @"Knock, knock, knock, Penny! Knock, knock, knock, Penny! Knock, knock, knock, Penny!",
    @"I’m not crazy, my mother had me tested."
};



@implementation ASStudent

+ (ASStudent*) createNewStudent {
    
    ASStudent *newStudent = [[ASStudent alloc]init];
    
    newStudent.firstName = firstNames [arc4random_uniform(studentsCount)];
    newStudent.lastName = lastNames [arc4random_uniform(studentsCount)];
    newStudent.birthDate = [NSDate generateRandomAgeForStudent];
    newStudent.studentPhrase = bazingaPhrases [arc4random_uniform(bazingaPhrasesCount)];
    newStudent.stdImage = [UIImage imageNamed:@"Sheldon2"];
    
    return newStudent;
   
}


-(NSString *)description {
    return [NSString stringWithFormat:@"I am %@ %@ (%@), wazzup ?", self.firstName,self.lastName, self.birthDate];
}




@end
