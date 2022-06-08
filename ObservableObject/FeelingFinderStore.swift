//
//  FeelingFinderStore.swift
//  Emojion
//
//  Created by Plus1XP on 23/04/2022.
//

import SwiftUI

class FeelingFinderStore: ObservableObject {
    @Published var feeling: [FeelingWheel] = [
        .init(name: "Angry", color: Color.red, secondaryFeelings: [
            FeelingWheel(name: "Aggressive", color: Color.red, tertiaryFeelings: [
                FeelingWheel(name: "Hostile", color: Color.red),
                FeelingWheel(name: "Provoked", color: Color.red)
                ]),
            FeelingWheel(name: "Bitter", color: Color.red, tertiaryFeelings: [
                FeelingWheel(name: "Indignant", color: Color.red),
                FeelingWheel(name: "Violated", color: Color.red)
                ]),
            FeelingWheel(name: "Critical", color: Color.red, tertiaryFeelings: [
                FeelingWheel(name: "Dismissive", color: Color.red),
                FeelingWheel(name: "Sceptical", color: Color.red)
                ]),
            FeelingWheel(name: "Distant", color: Color.red, tertiaryFeelings: [
                FeelingWheel(name: "Numb", color: Color.red),
                FeelingWheel(name: "Withdrawn", color: Color.red)
                ]),
            FeelingWheel(name: "Frustrated", color: Color.red, tertiaryFeelings: [
                FeelingWheel(name: "Annoyed", color: Color.red),
                FeelingWheel(name: "Infuriated", color: Color.red)
                ]),
            FeelingWheel(name: "Humiliated", color: Color.red, tertiaryFeelings: [
                FeelingWheel(name: "Disrespected", color: Color.red),
                FeelingWheel(name: "Ridiculed", color: Color.red)
                ]),
            FeelingWheel(name: "Let Down", color: Color.red, tertiaryFeelings: [
                FeelingWheel(name: "Betrayed", color: Color.red),
                FeelingWheel(name: "Resentful", color: Color.red)
                ]),
            FeelingWheel(name: "Mad", color: Color.red, tertiaryFeelings: [
                FeelingWheel(name: "Furious", color: Color.red),
                FeelingWheel(name: "Jealous", color: Color.red)
                ])
        ]),
        .init(name: "Bad", color: Color.green, secondaryFeelings: [
            FeelingWheel(name: "Bored", color: Color.green, tertiaryFeelings: [
                FeelingWheel(name: "Apathetic", color: Color.green),
                FeelingWheel(name: "Indifferent", color: Color.green)
                ]),
            FeelingWheel(name: "Busy", color: Color.green, tertiaryFeelings: [
                FeelingWheel(name: "Pressured", color: Color.green),
                FeelingWheel(name: "Rushed", color: Color.green)
                ]),
            FeelingWheel(name: "Stressed", color: Color.green, tertiaryFeelings: [
                FeelingWheel(name: "Out of Control", color: Color.green),
                FeelingWheel(name: "Overwhelmed", color: Color.green)
                ]),
            FeelingWheel(name: "Tired", color: Color.green, tertiaryFeelings: [
                FeelingWheel(name: "Sleepy", color: Color.green),
                FeelingWheel(name: "Unfocussed", color: Color.green)
                ])
        ]),
        .init(name: "Disgusted", color: Color.gray, secondaryFeelings: [
            FeelingWheel(name: "Awful", color: Color.gray, tertiaryFeelings: [
                FeelingWheel(name: "Detestable", color: Color.gray),
                FeelingWheel(name: "Nauseated", color: Color.gray)
                ]),
            FeelingWheel(name: "Disappointed", color: Color.gray, tertiaryFeelings: [
                FeelingWheel(name: "Appalled", color: Color.gray),
                FeelingWheel(name: "Revolted", color: Color.gray)
                ]),
            FeelingWheel(name: "Disapproving", color: Color.gray, tertiaryFeelings: [
                FeelingWheel(name: "Embarrassed", color: Color.gray),
                FeelingWheel(name: "Judgmental", color: Color.gray)
                ]),
            FeelingWheel(name: "Repelled", color: Color.gray, tertiaryFeelings: [
                FeelingWheel(name: "Hesitant", color: Color.gray),
                FeelingWheel(name: "Horrified", color: Color.gray)
                ])
        ]),
        .init(name: "Fearful", color: Color.orange, secondaryFeelings: [
            FeelingWheel(name: "Anxious", color: Color.orange, tertiaryFeelings: [
                FeelingWheel(name: "Overwhelmed", color: Color.orange),
                FeelingWheel(name: "Worried", color: Color.orange)
                ]),
            FeelingWheel(name: "Insecure", color: Color.orange, tertiaryFeelings: [
                FeelingWheel(name: "Inadequate", color: Color.orange),
                FeelingWheel(name: "Inferior", color: Color.orange)
                ]),
            FeelingWheel(name: "Rejected", color: Color.orange, tertiaryFeelings: [
                FeelingWheel(name: "Excluded", color: Color.orange),
                FeelingWheel(name: "Persecuted", color: Color.orange)
                ]),
            FeelingWheel(name: "Scared", color: Color.orange, tertiaryFeelings: [
                FeelingWheel(name: "Frightened", color: Color.orange),
                FeelingWheel(name: "Helpless", color: Color.orange)
                ]),
            FeelingWheel(name: "Threatened", color: Color.orange, tertiaryFeelings: [
                FeelingWheel(name: "Exposed", color: Color.orange),
                FeelingWheel(name: "Nervous", color: Color.orange)
                ]),
            FeelingWheel(name: "Weak", color: Color.orange, tertiaryFeelings: [
                FeelingWheel(name: "Insignificant", color: Color.orange),
                FeelingWheel(name: "Worthless", color: Color.orange)
                ])
        ]),
        .init(name: "Happy", color: Color.yellow, secondaryFeelings: [
            FeelingWheel(name: "Accepted", color: Color.yellow, tertiaryFeelings: [
                FeelingWheel(name: "Respected", color: Color.yellow),
                FeelingWheel(name: "Valued", color: Color.yellow)
                ]),
            FeelingWheel(name: "Content", color: Color.yellow, tertiaryFeelings: [
                FeelingWheel(name: "Free", color: Color.yellow),
                FeelingWheel(name: "Joyful", color: Color.yellow)
                ]),
            FeelingWheel(name: "Interested", color: Color.yellow, tertiaryFeelings: [
                FeelingWheel(name: "Curious", color: Color.yellow),
                FeelingWheel(name: "Inquisitive", color: Color.yellow)
                ]),
            FeelingWheel(name: "Optimistic", color: Color.yellow, tertiaryFeelings: [
                FeelingWheel(name: "Hopeful", color: Color.yellow),
                FeelingWheel(name: "Inspired", color: Color.yellow)
                ]),
            FeelingWheel(name: "Peaceful", color: Color.yellow, tertiaryFeelings: [
                FeelingWheel(name: "Loving", color: Color.yellow),
                FeelingWheel(name: "Thankful", color: Color.yellow)
                ]),
            FeelingWheel(name: "Playful", color: Color.yellow, tertiaryFeelings: [
                FeelingWheel(name: "Aroused", color: Color.yellow),
                FeelingWheel(name: "Cheeky", color: Color.yellow)
                ]),
            FeelingWheel(name: "Powerful", color: Color.yellow, tertiaryFeelings: [
                FeelingWheel(name: "Courageous", color: Color.yellow),
                FeelingWheel(name: "Creative", color: Color.yellow)
                ]),
            FeelingWheel(name: "Proud", color: Color.yellow, tertiaryFeelings: [
                FeelingWheel(name: "Confident", color: Color.yellow),
                FeelingWheel(name: "Successful", color: Color.yellow)
                ]),
            FeelingWheel(name: "Trusting", color: Color.yellow, tertiaryFeelings: [
                FeelingWheel(name: "Intimate", color: Color.yellow),
                FeelingWheel(name: "Sensitive", color: Color.yellow)
                ])
        ]),
        .init(name: "Sad", color: Color.blue, secondaryFeelings: [
            FeelingWheel(name: "Depressed", color: Color.blue, tertiaryFeelings: [
                FeelingWheel(name: "Empty", color: Color.blue),
                FeelingWheel(name: "Inferior", color: Color.blue)
                ]),
            FeelingWheel(name: "Despair", color: Color.blue, tertiaryFeelings: [
                FeelingWheel(name: "Grief", color: Color.blue),
                FeelingWheel(name: "Powerless", color: Color.blue)
                ]),
            FeelingWheel(name: "Guilty", color: Color.blue, tertiaryFeelings: [
                FeelingWheel(name: "Ashamed", color: Color.blue),
                FeelingWheel(name: "Remorseful", color: Color.blue)
                ]),
            FeelingWheel(name: "Hurt", color: Color.blue, tertiaryFeelings: [
                FeelingWheel(name: "Disappointed", color: Color.blue),
                FeelingWheel(name: "Embarrassed", color: Color.blue)
                ]),
            FeelingWheel(name: "Lonely", color: Color.blue, tertiaryFeelings: [
                FeelingWheel(name: "Abandoned", color: Color.blue),
                FeelingWheel(name: "Isolated", color: Color.blue)
                ]),
            FeelingWheel(name: "Vulnerable", color: Color.blue, tertiaryFeelings: [
                FeelingWheel(name: "Fragile", color: Color.blue),
                FeelingWheel(name: "Victimised", color: Color.blue)
                ])
        ]),
        .init(name: "Surprised", color: Color.purple, secondaryFeelings: [
            FeelingWheel(name: "Amazed", color: Color.purple, tertiaryFeelings: [
                FeelingWheel(name: "Astonished", color: Color.purple),
                FeelingWheel(name: "Awe", color: Color.purple)
                ]),
            FeelingWheel(name: "Confused", color: Color.purple, tertiaryFeelings: [
                FeelingWheel(name: "Disillusioned", color: Color.purple),
                FeelingWheel(name: "Perplexed", color: Color.purple)
                ]),
            FeelingWheel(name: "Excited", color: Color.purple, tertiaryFeelings: [
                FeelingWheel(name: "Eager", color: Color.purple),
                FeelingWheel(name: "Energetic", color: Color.purple)
                ]),
            FeelingWheel(name: "Startled", color: Color.purple, tertiaryFeelings: [
                FeelingWheel(name: "Dismayed", color: Color.purple),
                FeelingWheel(name: "Shocked", color: Color.purple)
                ])
        ])
    ]

    func resetArrayChoices(originalArray: [Int], newArray: [Int]) -> [Int] {
        var newArray = newArray
        
        if originalArray[0] != newArray[0] {
            newArray[1] = 0
            newArray[2] = 0
        }
        if originalArray[1] != newArray[1] {
            newArray[2] = 0
        }
        return newArray
    }
    
    func getSecondaryFeelingArray(feelingArray: [Int]) -> [FeelingWheel] {
        var newSelection: [FeelingWheel] = [FeelingWheel(name: "", color: Color.primary)]
        if !feelingArray.isEmpty {
            for emotion in feeling {
                if emotion.name == feeling[feelingArray[0]].name {
                    newSelection = emotion.secondaryFeelings
                }
            }
        }
        return newSelection
    }

    func getTertiaryFeelingArray(feelingArray: [Int]) -> [FeelingWheel] {
        var newSelection: [FeelingWheel] = [FeelingWheel(name: "", color: Color.primary)]
        if !feelingArray.isEmpty {
            for emotion in getSecondaryFeelingArray(feelingArray: feelingArray) {
                if emotion.name == feeling[feelingArray[0]].secondaryFeelings[feelingArray[1]].name {
                    newSelection = emotion.tertiaryFeelings
                }
            }
        }
        return newSelection
    }

    func getPrimarySelectedFeelingName(feelingArray: [Int]) -> String {
        if !feelingArray.isEmpty {
            return feeling[feelingArray[0]].name.capitalized
        } else {
            return ""
        }
    }

    func getSecondarySelectedFeelingName(feelingArray: [Int]) -> String {
        if !feelingArray.isEmpty {
            return feeling[feelingArray[0]].secondaryFeelings[feelingArray[1]].name.capitalized
        } else {
            return ""
        }
    }

    func getTertiarySelectedFeelingName(feelingArray: [Int]) -> String {
        if !feelingArray.isEmpty {
            return feeling[feelingArray[0]].secondaryFeelings[feelingArray[1]].tertiaryFeelings[feelingArray[2]].name.capitalized
        } else {
            return ""
        }
    }

    func getPrimarySelectedFeelingColor(feelingArray: [Int]) -> Color {
        if !feelingArray.isEmpty {
            return feeling[feelingArray[0]].color
        } else {
            return Color.primary
        }
    }

    func getSecondarySelectedFeelingColor(feelingArray: [Int]) -> Color {
        if !feelingArray.isEmpty {
            return feeling[feelingArray[0]].secondaryFeelings[feelingArray[1]].color
        } else {
            return Color.primary
        }
    }

    func getTertiarySelectedFeelingColor(feelingArray: [Int]) -> Color {
        if !feelingArray.isEmpty {
            return feeling[feelingArray[0]].secondaryFeelings[feelingArray[1]].tertiaryFeelings[feelingArray[2]].color
        } else {
            return Color.primary
        }
    }
}
