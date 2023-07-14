//
//  ViewController.m
//  ApplicazioneApple
//
//  Created by user231383 on 7/8/23.
//

#import "ConversController.h"
#import "FavoriteList.h"
#import "ConversionFinal.h"

@interface ConversController ()



@end


@implementation ConversController

@synthesize fieldFrom, fieldTo, fieldValue, convertValueLabel;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"CONVERTI";
    
    
    self.favorites = [[FavoriteList alloc] init];
    
    [self.favorites add:[[Favorite alloc] initFavorite:@"EUR" to:@"USD"]];
    [self.favorites add:[[Favorite alloc] initFavorite:@"USD" to:@"EUR"]];
    self.dataArray = [[NSMutableArray alloc] init];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FinalConversion"]) {
        ConversionFinal *destinationViewController = [segue destinationViewController];
        destinationViewController.mutableArray = _dataArray;
        destinationViewController.from = fieldFrom.text;
        destinationViewController.to = fieldTo.text;
        destinationViewController.valueConversion = [fieldValue.text integerValue];
    }
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    Favorite *select = [self.favorites getAtIndex:row];
    self.fieldTo.text = select.to;
    self.fieldFrom.text = select.from;
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return YES;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSInteger row = indexPath.row;
        [self.favorites removeItemAtIndex:row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
}

- (IBAction)addOnTable:(id)sender {
    
    if ( ![self checParamForApi:false] ) {
        return;
    }
    
    [self.favorites add:[[Favorite alloc] initFavorite:fieldFrom.text to:fieldTo.text]];
        
    // Aggiorna la UITableView
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.favorites size] - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (IBAction)convert:(id)sender {
    
    NSString *stringFrom = fieldFrom.text;
    NSString *stringTo = fieldTo.text;
    NSString *apiKey = @"Z0bNeRCu72rIMB4wQuSQOOGx0L9ZRYAXtLH2wMje";
    
    
    if ( ![self checParamForApi:true] ) {
        return;
    }
    
    
    NSDate *today = [NSDate date];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = -2; // Sottrai 7 giorni
    NSDate *yesterDayDate = [calendar dateByAddingComponents:dateComponents toDate:today options:0];
    dateComponents.day = -9; // Sottrai 7 giorni
    NSDate *sevenDaysAgoDate = [calendar dateByAddingComponents:dateComponents toDate:today options:0];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *yesterdayString = [dateFormatter stringFromDate:yesterDayDate];
    NSString *sevenDaysAgoString = [dateFormatter stringFromDate:sevenDaysAgoDate];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.freecurrencyapi.com/v1/historical?apikey=%@&currencies=%@&base_currency=%@&date_from=%@&date_to=%@", apiKey, stringTo, stringFrom, sevenDaysAgoString, yesterdayString];

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Errore durante la richiesta API: %@", error);
            return;
        }
        
        NSInteger statusCode = 0;

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        statusCode = httpResponse.statusCode;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@" . %@",urlString);
        
        if (statusCode == 200) {
            [self.dataArray removeAllObjects];

            // Elabora la risposta dell'API
            
            // Crea e popola il dizionario da passare
            
            // Assegna il dizionario alla proprietà dataDictionary
            
            for (NSString *key in responseDictionary[@"data"]) {
                NSDictionary *innerDict = responseDictionary[@"data"][key];
                NSString *numberString = innerDict[stringTo];
                NSLog(@"numberString: %@", numberString); // Stampa di debug
                NSNumber *number = @([numberString doubleValue]);
                [self.dataArray addObject:number];
            }
            
            NSLog(@"DataArray : %@", self.dataArray);

                
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"FinalConversion" sender:self];
            });
            
        } else {
            
            [self setViewError:[NSString stringWithFormat:@"Controlla le valute, non è stato possibile fare una conversione tra %@ e %@", stringFrom, stringTo]];

        }
        
        
        // Esegue la segue
        
    }];

    [dataTask resume];
    
}

- (BOOL)checParamForApi:(Boolean *)checkValue {
    
    Boolean passControl = YES;
    NSString *message = @"";
    
    if (!(fieldFrom.text.length == 3)) {
        fieldFrom.backgroundColor = [UIColor redColor]; // Imposta il colore di sfondo desiderato
        passControl = NO;
        message = [NSString stringWithFormat:@"%@ La valuta di partenza deve avere esattamente 3 caratteri \n ", message];
    } else {
        fieldFrom.backgroundColor = [UIColor systemGray6Color]; // Imposta il colore di sfondo desiderato
    }
    
    if (!(fieldTo.text.length == 3)) {
        fieldTo.backgroundColor = [UIColor redColor]; // Imposta il colore di sfondo desiderato
        passControl = NO;
        message = [NSString stringWithFormat:@"%@ \n La valuta di desinazione deve avere esattamente 3 caratteri ", message];
        
    } else {
        fieldTo.backgroundColor = [UIColor systemGray6Color]; // Imposta il colore di sfondo desiderato
    }
    
    if (checkValue){
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        NSNumber *number = [numberFormatter numberFromString:fieldValue.text];
        
        if (number == nil) {
            fieldValue.backgroundColor = [UIColor redColor]; // Imposta il colore di sfondo desiderato
            passControl = NO; // Nessuna field è vuota
            message = [NSString stringWithFormat:@"%@ \n Il campo del valore non puo avere lettere", message];
            
        } else {
            fieldValue.backgroundColor = [UIColor systemGray6Color]; // Imposta il colore di sfondo desiderato
        }
    }
    
    if (!passControl) {
        [self setViewError:message];
    }
    
    return passControl; // Nessuna field è vuota
    
}

-(void) setViewError:(NSString *)message {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Errore" message:message preferredStyle:UIAlertControllerStyleAlert];
    // Aggiunta di un'azione per chiudere il modal
    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"Chiudi" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:closeAction];
    // Presentazione del modal
    [self presentViewController:alertController animated:YES completion:nil];
    });
    
}


@end
 
