export class Event {
    public startDateTime: Date;
    public endDateTime: Date;

    constructor(
        public id: string,
        public name: string,
        public organizer: string,
        public venue: string,
        public description: string,
        startDate: string,
        endDate: string,
        public startMomentTime: string,
        public endMomentTime: string,
        public isAllDay: boolean,
        public stars: number,
        public coverImageUrl: string,
        public iLiked: boolean, ) {
        this.startDateTime = new Date(startDate);
        this.endDateTime = new Date(endDate);
    }

    static fromJson(json: Map<String, any>) {
        return new Event(
            json['id'],
            json['name'],
            json['organizer'],
            json['venue'],
            json['description'],
            json['startDateTime'],
            json['endDateTime'],
            json['startMomentTime'],
            json['endMomentTime'],
            json['isAllDay'],
            json['stars'],
            json['coverImageUrl'],
            json['iLiked'])
    }
}
