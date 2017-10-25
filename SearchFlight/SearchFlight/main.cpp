//
//  main.cpp
//  SearchFlight
//
//  Created by Cong Tran on 2014-08-22.
//  Copyright (c) 2014 Cong Tran. All rights reserved.
//
#include <stdio.h>
#include <iostream>
#include <fstream>
#include <string>
#include <ctime>
#include <locale>
#include <time.h>
#include <iomanip>

typedef struct flightInfo
{
    std::string Origin;
    std::string DepartureTime;
    std::string Destination;
    std::string DestinationTime;
    float Price;
    flightInfo *next;
} *fInfoPointer;


int main(int argc, const char * argv[])
{

    // insert code here...
    std::string inputO, inputOrigin, inputD, inputDestination;
    std::cin >> inputO;
    std::cin >> inputOrigin;
    std::cin >> inputD;
    std::cin >> inputDestination;
    std::ifstream file;
    std::string str;
    fInfoPointer fInfo=NULL;
    fInfoPointer fInfoFirst=NULL;
    int j=0,i=0;
    std::string delimiter = ",";
    std::cout << "starting..." << std::endl;
    for (int l=0;l<3;l++)
    {
        if (l == 0)
            file.open("Provider1.txt");
        else if (l == 1)
            file.open("Provider2.txt");
        else
            file.open("Provider3.txt");
        j = 0;
        while (std::getline(file, str))
        {
            // skip the header line
            if (j == 0)
            {
                j = 1;
                continue;
            }
            fInfo = new struct flightInfo;
            size_t pos = 0;
            std::string token;
            char *pEnd;
            if (l == 2)
                delimiter = "|";
            i=0;
            while ((pos = str.find(delimiter)) != std::string::npos) {
                if (i == 0)
                    fInfo->Origin = str.substr(0, pos);
                else if (i == 1)
                    fInfo->DepartureTime = str.substr(0, pos);
                else if (i == 2)
                    fInfo->Destination = str.substr(0, pos);
                else if (i == 3)
                    fInfo->DestinationTime = str.substr(0, pos);
                str.erase(0, pos + delimiter.length());
                i++;
            }
            if (fInfo->Origin.compare(inputOrigin) != 0 || fInfo->Destination.compare(inputDestination) != 0)
            {
                continue;
            }
            str.erase(0,1);
            fInfo->Price = strtof(str.c_str(), &pEnd);
            if (fInfoFirst == NULL)
            {
                fInfoFirst = fInfo;
                fInfoFirst->next = NULL;
            }
            else
            {
                fInfoPointer fItem = fInfoFirst;
                struct tm tm2;
                strptime(fInfo->DepartureTime.c_str(), "%m/%d/%Y %H:%M:%S", &tm2);
                time_t t2 = mktime(&tm2);
                if (fItem->Origin.compare(fInfo->Origin) == 0 &&
                    fItem->DepartureTime.compare(fInfo->DepartureTime) == 0 &&
                    fItem->Destination.compare(fInfo->Destination) == 0 &&
                    fItem->DestinationTime.compare(fInfo->DestinationTime) == 0 &&
                    fItem->Price == fInfo->Price)
                {
                    delete fInfo;
                    continue;
                }
                else
                {
                    if (fItem->Price == fInfo->Price)
                    {
                        struct tm tm;
                        strptime(fItem->DepartureTime.c_str(), "%m/%d/%Y %H:%M:%S", &tm);
                        time_t t1 = mktime(&tm);
                    
                        if (t1 == t2 || t1 > t2)
                        {
                            fInfoFirst = fInfo;
                            fInfo->next = fItem;
                            fItem->next= NULL;
                        }
                        else
                        {
                            if (fItem->next == NULL)
                            {
                                fItem->next= fInfo;
                                fInfo->next = NULL;
                            }
                            else
                            {
                                fInfoPointer prevInfo = fItem;
                                fItem = fItem->next;
                                bool found = false;
                                while (fItem && fItem->Price == fInfo->Price)
                                {
                                    struct tm tm1;
                                    strptime(fItem->DepartureTime.c_str(), "%m/%d/%Y %H:%M:%S", &tm1);
                                    time_t t3 = mktime(&tm1);
                                    if (t3 < t2 || t3 == t2)
                                    {
                                        prevInfo->next = fInfo;
                                        fInfo->next = fItem;
                                        found = true;
                                        break;
                                    }
                                }
                                if (!found)
                                {
                                    prevInfo = fInfo;
                                    fInfo->next = fItem;
                                }
                            }
                        }
                    }
                    else if (fItem->Price > fInfo->Price)
                    {
                        fInfoFirst = fInfo;
                        fInfo->next = fItem;
                    }
                    else
                    {
                        if (fItem->next == NULL)
                        {
                            fItem->next= fInfo;
                            fInfo->next = NULL;
                        }
                        else
                        {
                            fInfoPointer prevInfo = fItem;
                            fItem = fItem->next;
                            bool found = false;
                            while (fItem && fItem->Price > fInfo->Price)
                            {
                                prevInfo = fInfo;
                                fInfo->next = fItem;
                                found = true;
                                break;
                            }
                            if (found)
                            {
                                prevInfo = fInfo;
                                fInfo->next = fItem;
                            }
                            else
                            {
                                if (fItem->Price == fInfo->Price)
                                {
                                    found = false;
                                    while (fItem && fItem->Price == fInfo->Price)
                                    {
                                        prevInfo = fInfo;
                                        fInfo->next = fItem;
                                        struct tm tm1;
                                        strptime(fItem->DepartureTime.c_str(), "%m/%d/%Y %H:%M:%S", &tm1);
                                        time_t t3 = mktime(&tm1);
                                        if (t3 < t2 || t3 == t2)
                                        {
                                            prevInfo->next = fInfo;
                                            fInfo->next = fItem;
                                            found = true;
                                            break;
                                        }
                                        else
                                            fItem = fItem->next;
                                    }
                                    if (!found)
                                    {
                                        prevInfo = fInfo;
                                        fInfo->next = fItem;
                                    }
                                }
                                else
                                {
                                    prevInfo = fInfo;
                                    fInfo->next = fItem;
                                }
                            }
                        }
                    }
                }
            }
        }
        file.close();
    }
    fInfoPointer fItem = fInfoFirst;
    fInfoPointer fPrevInfo=NULL, fBeforePrev=NULL;
    while (fItem)
    {
        std::cout << fItem->Origin << " --> " << fItem->Destination << " (";
        std::replace(fItem->DepartureTime.begin(), fItem->DepartureTime.end(), '-', '/');
        std::replace(fItem->DestinationTime.begin(), fItem->DestinationTime.end(), '-', '/');
        std::cout << fItem->DepartureTime << " --> " << fItem->DestinationTime << ") - $";
        std::cout << std::fixed;
        std::cout << std::setprecision(2);
        std::cout << fItem->Price << std::endl;
        fBeforePrev = fPrevInfo;
        fPrevInfo = fItem;
        fItem = fItem->next;
        delete fBeforePrev;
    }
    if (fPrevInfo)
        delete fPrevInfo;
    return 0;
}

