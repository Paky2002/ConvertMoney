//
//  ViewController.m
//  ApplicazioneApple
//
//  Created by user231383 on 7/8/23.
//

#import "ViewController.h"
#import "FavoriteList.h"

@interface ViewController ()

@property (nonatomic, strong) FavoriteList *favorites;

@end


@implementation ViewController

@synthesize fieldFrom, fieldTo, fieldValue, convertValueLabel;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.favorites = [[FavoriteList alloc] init];
    
    [self.favorites add:[[Favorite alloc] initFavorite:@"EUR" to:@"USD"]];
    [self.favorites add:[[Favorite alloc] initFavorite:@"USD" to:@"EUR"]];

    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favorites.size;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PreferitiRow" forIndexPath:indexPath];
    Favorite *f = [self.favorites getAtIndex:indexPath.row];
    cell.textLabel.text = f.displayFavorite;
    return cell;
}


- (IBAction)convert:(id)sender {
    
    NSString *stringFrom = fieldFrom.text;
    NSString *stringTo = fieldTo.text;
    NSString *apiKey = @"Z0bNeRCu72rIMB4wQuSQOOGx0L9ZRYAXtLH2wMje";
    
    
    NSDate *today = [NSDate date];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = -7; // Sottrai 7 giorni
    NSDate *sevenDaysAgo = [calendar dateByAddingComponents:dateComponents toDate:today options:0];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *todayString = [dateFormatter stringFromDate:today];
    NSString *sevenDaysAgoString = [dateFormatter stringFromDate:sevenDaysAgo];

    NSLog(@"Data di oggi: %@", todayString);
    NSLog(@"Data di sette giorni fa: %@", sevenDaysAgoString);
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.freecurrencyapi.com/v1/latest?apikey=%@&currencies=%@&base_currency=%@&date_from=%@&date_to=%@", apiKey, stringTo, stringFrom, sevenDaysAgoString, todayString];

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Errore durante la richiesta API: %@", error);
            return;
        }
        
        // Elabora la risposta dell'API
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *rates = responseDictionary[@"data"];
        NSString *convertedRates = rates[todayString][stringTo];
        NSLog(@"API: %@", urlString);

        dispatch_async(dispatch_get_main_queue(), ^{
            // Aggiorna la UI con il valore EUR
            self.convertValueLabel.text = [NSString stringWithFormat:@"%@",convertedRates];
        });
        



        
        

        
    }];

    [dataTask resume];

    
}
@end
